import 'package:flutter/material.dart';

class StartupFailure extends StatelessWidget {
  const StartupFailure({super.key, required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Grocery prototype')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Firebase could not start. Check your connection and Firebase platform configuration.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    ),
  );
}
