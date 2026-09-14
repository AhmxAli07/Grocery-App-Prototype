import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  const MySnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                final message = SnackBar(content: Text('Added'));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(message); // Changed showSnackbar to showSnackBar
              },
              child: Text('Snack Bar'),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MySnackBar()));
}
