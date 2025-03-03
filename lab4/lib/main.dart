import 'package:flutter/material.dart';
import 'router.dart';

enum Routes {
  mainScreen,
  calculator1,
  calculator2,
  calculator3,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
