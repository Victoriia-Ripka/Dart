import 'package:flutter/material.dart';
import 'package:lab5/screens/components/fancy_button.dart';
import 'package:lab5/screens/components/header.dart';

class EntryScreen extends StatelessWidget {
  final VoidCallback onCalculator1Navigate;
  final VoidCallback onCalculator2Navigate;

  const EntryScreen({
    super.key,
    required this.onCalculator1Navigate,
    required this.onCalculator2Navigate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Головний екран")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomHeader(), // Заголовок

            FancyButton(
              text: "Калькулятор 1",
              onClick: onCalculator1Navigate,
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30), // Spacer

            FancyButton(
              text: "Калькулятор 2",
              onClick: onCalculator2Navigate,
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}