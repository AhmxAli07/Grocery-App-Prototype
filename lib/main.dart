import 'package:prototype/Extra/extra.dart';
import 'package:prototype/Extra/fav.dart';
import 'package:prototype/Phone_Number/you.dart';
import 'package:prototype/Screens/bar.dart';
import 'package:prototype/Screens/forget.dart';
import 'package:prototype/auth/signup.dart';
import 'package:prototype/categories/Desert.dart/cake.dart';
import 'package:prototype/categories/Desert.dart/egg.dart';
import 'package:prototype/categories/Desert.dart/ice.dart';
import 'package:prototype/categories/Desert.dart/juice.dart';
import 'package:prototype/categories/Fruits/apple.dart';
import 'package:prototype/categories/Fruits/avocado.dart';
import 'package:prototype/categories/Fruits/banana.dart';
import 'package:prototype/categories/Fruits/grape.dart';
import 'package:prototype/categories/Meat/cow.dart';
import 'package:prototype/categories/Meat/fish.dart';
import 'package:prototype/categories/Meat/pump.dart';
import 'package:prototype/categories/Meat/sea.dart';
import 'package:prototype/payment/pay.dart';
import 'package:prototype/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'state_util.dart';
import 'widgets/startup_failure.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(const Duration(seconds: 20));
    runApp(const GroceryApp());
  } catch (_) {
    runApp(MaterialApp(home: StartupFailure(onRetry: main)));
  }
}
// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const GroceryApp());
// }

// ignore: camel_case_types
class GroceryApp extends StatefulWidget {
  const GroceryApp({super.key});

  @override
  State<GroceryApp> createState() => _GroceryAppState();
}

// ignore: camel_case_types
class _GroceryAppState extends State<GroceryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/extra': (context) => const CartScreen(),
        '/forget': (context) => const PasswordResetScreen(),
        '/BottomNavBar': (context) => BottomNavBar(),
        '/grape': (context) => const GrapeScreen(),
        '/banana': (context) => const BananaScreen(),
        '/apple': (context) => const AppleScreen(),
        '/avocado': (context) => const AvocadoScreen(),
        '/Meat': (context) => const C(),
        '/Sea': (context) => const S(),
        '/Pumpkins': (context) => const P(),
        '/Fish': (context) => const F(),
        '/phone': (context) => const You(),
        '/cart': (context) => const FavoritesScreen(),
        '/ic': (context) => const IceCreamScreen(),
        '/ca': (context) => const CakeScreen(),
        '/e': (context) => const EggScreen(),
        '/j': (context) => const JuiceScreen(),
        '/pay': (context) => const PaymentScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false, primaryColor: Colors.lightBlue),
    );
  }
}
