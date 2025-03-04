import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const CustomTitle({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: textStyle.copyWith(color: Colors.black),
      ),
    );
  }
}