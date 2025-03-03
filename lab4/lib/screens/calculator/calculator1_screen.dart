import 'package:flutter/material.dart';
import '../../services/calculator_service.dart';

class Calculator1Screen extends StatefulWidget {
  final VoidCallback goBack;

  const Calculator1Screen({super.key, required this.goBack});

  @override
  _Calculator1ScreenState createState() => _Calculator1ScreenState();
}

class _Calculator1ScreenState extends State<Calculator1Screen> {
  String conductor = "";
  String cableType = "";
  int timeRange = 1000;
  String result = "";

  late final CalculatorService calculatorService;

  final List<String> conductors = [
    "Неізольовані проводи та шини",
    "Кабелі з паперовою та проводи гумовою ізоляцією",
    "Кабелі з гумовою та пластмасовою ізоляцією"
  ];

  final List<String> cableTypes = ["Алюмінієві", "Мідні"];
  final List<int> timeRanges = List.generate(10, (index) => (index + 1) * 1000);

  @override
  void initState() {
    super.initState();
    calculatorService = CalculatorService();
  }

  void calculateResult() {
    setState(() {
      result = calculatorService
          .calculateCablesCompatibility(conductor, cableType, timeRange.toDouble())
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator 1")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Conductor Dropdown
            DropdownButtonFormField<String>(
              value: conductor.isEmpty ? null : conductor,
              decoration: const InputDecoration(labelText: "Оберіть проводник"),
              items: conductors.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) => setState(() => conductor = value ?? ""),
            ),
            const SizedBox(height: 8),

            // Cable Type Dropdown
            DropdownButtonFormField<String>(
              value: cableType.isEmpty ? null : cableType,
              decoration: const InputDecoration(labelText: "Оберіть тип кабелю"),
              items: cableTypes.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) => setState(() => cableType = value ?? ""),
            ),
            const SizedBox(height: 8),

            // Time Range Dropdown
            DropdownButtonFormField<int>(
              value: timeRange,
              decoration: const InputDecoration(labelText: "Зазначте час (1000-10000)"),
              items: timeRanges.map((item) {
                return DropdownMenuItem(value: item, child: Text(item.toString()));
              }).toList(),
              onChanged: (value) => setState(() => timeRange = value ?? 1000),
            ),
            const SizedBox(height: 16),

            // Calculate Button
            ElevatedButton(
              onPressed: calculateResult,
              child: const Text("Розрахувати"),
            ),

            if (result.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text("Результат: потрібно змінити переріз жил до $result мм²",
                  style: const TextStyle(fontSize: 16)),
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