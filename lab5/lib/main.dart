import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab5/services/calculator_service.dart';
import 'package:lab5/screens/calculator/calculator1_screen.dart';
import 'package:lab5/screens/calculator/calculator2_screen.dart';
import 'package:lab5/screens/entry_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lab 5',
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
        onCalculator1Navigate: () => context.go('/calculator1'),
        onCalculator2Navigate: () => context.go('/calculator2'),
      ),
    ),
    GoRoute(
      path: '/calculator1',
      name: 'calculator_1',
      builder: (context, state) => Calculator1Screen(
        goBack: () => context.go('/'),
        calculatorService: CalculatorService(),
      ),
    ),
    GoRoute(
      path: '/calculator2',
      name: 'calculator_2',
      builder: (context, state) => Calculator2Screen(
        goBack: () => context.go('/'),
        calculatorService: CalculatorService(),
      ),
    ),
  ],
);