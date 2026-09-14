import 'package:flutter/material.dart';
import 'upload.dart';

/// Legacy entry point for the photo experiment; this is not order history.
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) => const PhotoUploadScreen();
}
