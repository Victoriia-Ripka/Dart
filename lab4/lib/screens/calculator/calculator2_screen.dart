import 'package:flutter/material.dart';
import '../../services/calculator_service.dart';

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
  final TextEditingController _uController = TextEditingController();
  final TextEditingController _skController = TextEditingController();
  final TextEditingController _sNomtController = TextEditingController();

  String result = "";

  void calculateCurrent() {
    double formattedU = double.tryParse(_uController.text) ?? 0.0;
    double formattedSk = double.tryParse(_skController.text) ?? 0.0;
    double formattedSNomt = double.tryParse(_sNomtController.text) ?? 0.0;

    setState(() {
      result = widget.calculatorService.determinateCurrent(
        u: formattedU,
        sk: formattedSk,
        sNomt: formattedSNomt,
      ).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator 2")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Fields
            TextField(
              controller: _uController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Ведіть напругу"),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _skController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Введіть потужність КЗ"),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _sNomtController,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: "Введіть номінальну потужність трансформатора"),
            ),
            const SizedBox(height: 16),

            // Calculate Button
            ElevatedButton(
              onPressed: calculateCurrent,
              child: const Text("Розрахувати"),
            ),

            if (result.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text("Результат: $result кА", style: const TextStyle(fontSize: 16)),
            ],

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