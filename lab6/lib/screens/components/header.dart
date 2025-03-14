import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Практична робота №5.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600, // SemiBold
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Розробник: Новотка Вікторія',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600, // SemiBold
          ),
        ),
      ],
    );
  }
}