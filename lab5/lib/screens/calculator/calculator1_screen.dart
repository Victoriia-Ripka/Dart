import 'package:flutter/material.dart';
import 'package:lab5/services/calculator_service.dart';
import 'package:lab5/screens/components/fancy_button.dart';
import 'package:lab5/screens/components/header.dart';
import 'package:lab5/screens/components/title.dart';

class Calculator1Screen extends StatefulWidget {
  final VoidCallback goBack;
  final CalculatorService calculatorService;

  const Calculator1Screen({
    super.key,
    required this.goBack,
    required this.calculatorService,
  });

  @override
  _Calculator1ScreenState createState() => _Calculator1ScreenState();
}

class _Calculator1ScreenState extends State<Calculator1Screen> {
  late List<double> resultArray;
  late double w_dk;
  late double w_ds;

  @override
  void initState() {
    super.initState();
    resultArray = [0.0, 0.0];
    w_dk = resultArray[0];
    w_ds = resultArray[1];
  }

  void calculate() {
    setState(() {
      resultArray = widget.calculatorService.compareReliabilitySystems();
      w_dk = resultArray[0];
      w_ds = resultArray[1];
      print("w_dk screen: $w_dk");
      print("w_ds screen: $w_ds");
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
              text: "Завдання 1",
              textStyle: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            CustomTitle(
              text: "Порівняння надійності одноколової та двоколової систем електропередач",
              textStyle: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            FancyButton(
              text: "Розрахувати",
              onClick: calculate,
            ),
            if (resultArray[0] != 0.0) ...[
              SizedBox(height: 50),
              Text("Результат: w_dk = $w_dk, w_ds = $w_ds \nНадійність двоколової системи є вищою"),
            ],
            if (resultArray[0] == 0.0) Spacer(),
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