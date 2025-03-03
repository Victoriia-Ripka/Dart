import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab4/main.dart';

class EntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lab 4")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.goNamed(Routes.calculator1.name),
              child: Text("Go to Calculator 1"),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(Routes.calculator2.name),
              child: Text("Go to Calculator 2"),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(Routes.calculator3.name),
              child: Text("Go to Calculator 3"),
            ),
          ],
        ),
      ),
    );
  }
}