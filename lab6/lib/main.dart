import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab6/screens/calculator/calculator_screen.dart';
import 'package:lab6/screens/entry_screen.dart';
import 'package:lab6/services/calculator_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lab 6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

// Маршрутизація за допомогою GoRouter
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'main_screen',
      builder: (context, state) => EntryScreen(
        onCalculator1Navigate: () => context.go('/calculator'),
      ),
    ),
    GoRoute(
      path: '/calculator',
      name: 'calculator',
      builder: (context, state) => CalculatorScreen(
        goBack: () => context.go('/'),
        calculatorService: CalculatorService(),
      ),
    ),
  ],
);