import 'package:flutter/material.dart';
import 'you.dart';

/// Compatibility entry point for an earlier phone-authentication experiment.
class LegacyPhoneScreen extends StatelessWidget {
  const LegacyPhoneScreen({super.key});
  @override
  Widget build(BuildContext context) => const You();
}
