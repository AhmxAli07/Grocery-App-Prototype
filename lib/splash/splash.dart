import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      if (auth.currentUser == null) {
        // here login Screen******
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // here home Screen******
        Navigator.pushReplacementNamed(context, '/BottomNavBar');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('SPLASH')));
  }
}
