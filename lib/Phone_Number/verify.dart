import 'package:flutter/material.dart';
import 'tube.dart';

class LegacyVerificationScreen extends StatelessWidget {
  const LegacyVerificationScreen({super.key, required this.verificationId});
  final String verificationId;
  @override
  Widget build(BuildContext context) =>
      CodeVerificationScreen(verificationId: verificationId);
}
