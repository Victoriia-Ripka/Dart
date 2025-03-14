import 'package:flutter/material.dart';
import 'components/fancy_button.dart';
import 'components/header.dart';

class EntryScreen extends StatelessWidget {
  final VoidCallback onCalculator1Navigate;

  const EntryScreen({super.key, required this.onCalculator1Navigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomHeader(),
          const SizedBox(height: 30),
          FancyButton(
            text: "Калькулятор 1",
            onClick: onCalculator1Navigate,
          ),
        ],
      ),
    );
  }
}