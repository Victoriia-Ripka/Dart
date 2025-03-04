import 'package:flutter/material.dart';
import 'package:lab5/services/calculator_service.dart';
import 'package:lab5/screens/components/fancy_button.dart';
import 'package:lab5/screens/components/header.dart';
import 'package:lab5/screens/components/title.dart';

class Calculator2Screen extends StatefulWidget {
  final VoidCallback goBack;
  final CalculatorService calculatorService;

  const Calculator2Screen({
    super.key,
    required this.goBack,
    required this.calculatorService,
  });

  @override
  _Calculator2ScreenState createState() => _Calculator2ScreenState();
}

class _Calculator2ScreenState extends State<Calculator2Screen> {
  late String result;

  @override
  void initState() {
    super.initState();
    result = "";
  }

  void calculate() {
    setState(() {
      result = widget.calculatorService.calculateLoses();
      print("result screen: $result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Column(
          children: [
            CustomHeader(),
            CustomTitle(
              text: "Завдання 2",
              textStyle: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            CustomTitle(
              text: "Розрахунок збитків від перерв електропостачання",
              textStyle: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            FancyButton(
              text: "Розрахувати",
              onClick: calculate,
            ),
            if (result.isNotEmpty) ...[
              SizedBox(height: 70),
              Text("Математичне сподівання збитків від переривання електропостачання: $result"),
            ],
            if (result.isEmpty) Spacer(),
            FancyButton(
              text: "Повернутися назад",
              onClick: widget.goBack,
            ),
          ],
        ),
      ),
    );
  }
}