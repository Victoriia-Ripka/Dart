import 'package:flutter/material.dart';
import 'package:lab1/screens/first_calculator_screen.dart';
import 'package:lab1/screens/second_calculator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 1')),
      body: Center(
        child: SingleChildScrollView( // Fix: Properly wrapping it inside Center
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstCalculatorScreen()),
                  );
                },
                child: const Text('Go to First Calculator'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondCalculatorScreen()),
                  );
                },
                child: const Text('Go to Second Calculator'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}