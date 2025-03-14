import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Lab6',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// Налаштування маршрутизації
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) => const CalculatorScreen(),
    ),
  ],
);


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Практична робота №6')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Ensures horizontal centering
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Keeps content aligned to the top
            crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
            children: [
              const Text(
                'Розробник: ТВ-13 Новотка Вікторія',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Ensures text is centered
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.push('/calculator');
                },
                child: Text('Калькулятор 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}