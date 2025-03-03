import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const calculator1 = 'calculator1';
  static const calculator2 = 'calculator2';
  static const calculator3 = 'calculator3';
}

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lab 4")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.goNamed(Routes.calculator1),
              child: Text("Go to Calculator 1"),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(Routes.calculator2),
              child: Text("Go to Calculator 2"),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(Routes.calculator3),
              child: Text("Go to Calculator 3"),
            ),
          ],
        ),
      ),
    );
  }
}