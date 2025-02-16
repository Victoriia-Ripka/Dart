import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab2 - Fuel Composition Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Fuel Composition Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String errorText = '';
  String resultText = '';

  final TextEditingController coalController = TextEditingController();
  final TextEditingController fuelController = TextEditingController();
  final TextEditingController gasController = TextEditingController();

  final double qCoal = 20.47;
  final double gVynCoal = 1.5;
  final double aVynCoal = 0.8;
  final double aRCoal = 25.2;
  final double nZuCoal = 0.985;
  final double kHSCoal = 0.0;

  final double qFuel = 40.40;
  final double gVynFuel = 0.0;
  final double aVynFuel = 1.0;
  final double aRFuel = 0.15;
  final double nZuFuel = 0.985;
  final double kHSFuel = 0.0;

  final double qGas = 20.47;
  final double gVynGas = 1.5;
  final double aVynGas = 0.8;
  final double aRGas = 25.2;
  final double nZuGas = 0.985;
  final double kHSGas = 0.0;

  double calculateK(double q, double aVyn, double aR, double gVyn, double nZu, double kHS) {
    return ((pow(10, 6) * aVyn * aR) / (q * (100 - gVyn))) * (1 - nZu) + kHS;
  }

  double calculateE(double k, double b, double q) {
    return pow(10, -6) * k * b * q;
  }

  void doCalculations() {

    final List<double?> values = [
      double.tryParse(coalController.text),
      double.tryParse(fuelController.text),
      double.tryParse(gasController.text)
    ];

    if (values.contains(null)) {
      setState(() {
        resultText = "";
        errorText = "Будь ласка, введіть всі значення";
      });
      return;
    }

    final double coalV = values[0]!;
    final double fuelV = values[1]!;
    final double gasV = values[2]!;

    final double kCoalValue = double.parse(
        calculateK(qCoal, aVynCoal, aRCoal, gVynCoal, nZuCoal, kHSCoal).toStringAsFixed(2));
    final double eCoalValue = double.parse(
        calculateE(kCoalValue, coalV, qCoal).toStringAsFixed(2));

    final double kFuelValue = double.parse(
        calculateK(qFuel, aVynFuel, aRFuel, gVynFuel, nZuFuel, kHSFuel).toStringAsFixed(2));
    final double eFuelValue = double.parse(
        calculateE(kFuelValue, fuelV, qFuel).toStringAsFixed(2));

    final double kGasValue = 0.0;
    final double eGasValue = double.parse(
        calculateE(kGasValue, gasV, qGas).toStringAsFixed(2));

    setState(() {
      resultText= """
      Показник емісії твердих частинок при спалюванні вугілля становитиме: $kCoalValue г/ГДж;
      Валовий викид при спалюванні вугілля становитиме: $eCoalValue т.
      Показник емісії твердих частинок при спалюванні мазуту становитиме: $kFuelValue г/ГДж;
      Валовий викид при спалюванні мазуту становитиме: $eFuelValue т.
      Показник емісії твердих частинок при спалюванні природного газу становитиме: $kGasValue г/ГДж;
      Валовий викид при спалюванні природного газу становитиме: $eGasValue т. """;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: coalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вугілля (kg)'),
            ),
            TextField(
              controller: fuelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Мазут (kg)'),
            ),
            TextField(
              controller: gasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Природній газ (kg)'),
            ),

            ElevatedButton(onPressed: doCalculations, child: const Text("Розрахувати")),

            if (errorText.isNotEmpty)
              Text(
                errorText,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),

            if (resultText.isNotEmpty)
              Text(
                resultText,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

          ],
        ),
      ),
    );
  }
}
