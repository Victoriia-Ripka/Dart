import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Calculator1Screen extends StatelessWidget {
  const Calculator1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
