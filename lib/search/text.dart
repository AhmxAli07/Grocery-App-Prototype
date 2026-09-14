import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _isEditable = false;

  @override
  void initState() {
    super.initState();
    _controller.text = "Initial Text"; // Set the initial text value
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: TextStyle(
        color: _isEditable
            ? Colors.black
            : Colors.grey, // Change text color when editable
      ),
      readOnly: !_isEditable,
      onTap: () {
        setState(() {
          _isEditable = true;
        });
      },
      onSubmitted: (newValue) {
        setState(() {
          _isEditable = false;
        });
        // Handle the submitted value if needed
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
