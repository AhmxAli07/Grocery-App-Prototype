import 'package:flutter/material.dart';

BuildContext get globalContext {
  return Get.currentContext ?? (throw StateError('Navigator is not mounted.'));
}

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get currentContext {
    return navigatorKey.currentState?.context;
  }

  static Future<dynamic> to(Widget page) async {
    return await navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void back() {
    if (Navigator.canPop(globalContext) == false) return;
    Navigator.pop(globalContext);
  }

  static Future<dynamic> offAll(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  static double get width {
    return MediaQuery.of(globalContext).size.width;
  }

  static double get height {
    return MediaQuery.of(globalContext).size.height;
  }

  static ValueNotifier<ThemeData> mainTheme = ValueNotifier<ThemeData>(
    ThemeData(),
  );
  static void changeTheme(ThemeData theme) {
    mainTheme.value = theme;
  }

  static ThemeData get theme {
    return Theme.of(globalContext);
  }
}
