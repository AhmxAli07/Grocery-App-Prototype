import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({
    super.key,
    this.verificationId,
    this.confirmation,
  });
  final String? verificationId;
  final ConfirmationResult? confirmation;
  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  String _code = '';
  bool _loading = false;
  Future<void> _verify() async {
    if (_loading || _code.length != 6) return;
    setState(() => _loading = true);
    try {
      if (widget.confirmation != null) {
        await widget.confirmation!.confirm(_code);
      } else if (widget.verificationId?.isNotEmpty == true) {
        await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(
            verificationId: widget.verificationId!,
            smsCode: _code,
          ),
        );
      } else {
        throw FirebaseAuthException(
          code: 'missing-verification-id',
          message: 'Request a verification code first.',
        );
      }
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/BottomNavBar',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Verification failed.')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Verify code')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Pinput(length: 6, onChanged: (value) => setState(() => _code = value)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _loading || _code.length != 6 ? null : _verify,
          child: Text(_loading ? 'Verifying…' : 'Done'),
        ),
      ],
    ),
  );
}
