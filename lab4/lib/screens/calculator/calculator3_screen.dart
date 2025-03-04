import 'package:flutter/material.dart';
import '../../services/calculator_service.dart';

class Calculator3Screen extends StatefulWidget {
  final VoidCallback goBack;
  final CalculatorService calculatorService;

  const Calculator3Screen({
    super.key,
    required this.goBack,
    required this.calculatorService,
  });

  @override
  _Calculator3ScreenState createState() => _Calculator3ScreenState();
}

class _Calculator3ScreenState extends State<Calculator3Screen> {
  List<double> resultArray = [];

  void calculateResult() {
    setState(() async {
      resultArray = await widget.calculatorService.determinateSubstationCurrent();
    });
  }

  @override
  Widget build(BuildContext context) {
    double i3LN = resultArray.isNotEmpty ? resultArray[0] : 0.0;
    double i2LN = resultArray.isNotEmpty ? resultArray[1] : 0.0;
    double i3LNmin = resultArray.isNotEmpty ? resultArray[2] : 0.0;
    double i2LNmin = resultArray.isNotEmpty ? resultArray[3] : 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text("Calculator 3")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Calculate Button
            ElevatedButton(
              onPressed: calculateResult,
              child: const Text("Розрахувати"),
            ),

            const SizedBox(height: 16),

            // Display Results
            if (resultArray.isNotEmpty)
              Text(
                "Результат: I3 = $i3LN А, I2 = $i2LN А, "
                    "I3 min = $i3LNmin А, I2 min = $i2LNmin А.\n"
                    "Аварійний режим не передбачено.",
                style: const TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 50),

            // Go Back Button
            ElevatedButton(
              onPressed: widget.goBack,
              child: const Text("Повернутися до головного меню"),
            ),
          ],
        ),
      ),
    );
  }
}