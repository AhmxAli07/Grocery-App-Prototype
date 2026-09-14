import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'tube.dart';

class You extends StatefulWidget {
  const You({super.key});
  @override
  State<You> createState() => _YouState();
}

class _YouState extends State<You> {
  final _formKey = GlobalKey<FormState>();
  String _phone = '';
  bool _loading = false;
  void _error(String message) {
    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _sendCode() async {
    if (_loading || !_formKey.currentState!.validate() || _phone.isEmpty) {
      return;
    }
    setState(() => _loading = true);
    final auth = FirebaseAuth.instance;
    try {
      if (kIsWeb) {
        final confirmation = await auth.signInWithPhoneNumber(_phone);
        if (!mounted) return;
        await Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) =>
                CodeVerificationScreen(confirmation: confirmation),
          ),
        );
        if (mounted) setState(() => _loading = false);
      } else {
        await auth.verifyPhoneNumber(
          phoneNumber: _phone,
          verificationCompleted: (credential) async {
            try {
              await auth.signInWithCredential(credential);
              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/BottomNavBar',
                (route) => false,
              );
            } on FirebaseAuthException catch (e) {
              _error(e.message ?? 'Verification failed.');
            }
          },
          verificationFailed: (e) =>
              _error(e.message ?? 'Could not send a code.'),
          codeSent: (verificationId, resendToken) async {
            if (!mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) =>
                    CodeVerificationScreen(verificationId: verificationId),
              ),
            );
            if (mounted) setState(() => _loading = false);
          },
          codeAutoRetrievalTimeout: (_) {
            if (mounted) setState(() => _loading = false);
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      _error(e.message ?? 'Could not send a code.');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Phone sign in')),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          IntlPhoneField(
            initialCountryCode: 'PK',
            decoration: const InputDecoration(labelText: 'Phone number'),
            onChanged: (number) => _phone = number.completeNumber,
          ),
          ElevatedButton(
            onPressed: _loading ? null : _sendCode,
            child: Text(_loading ? 'Sending code…' : 'Send code'),
          ),
        ],
      ),
    ),
  );
}
