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
      title: 'Lab3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Calculator'),
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

  final TextEditingController pCController = TextEditingController();
  final TextEditingController sigmaController = TextEditingController();
  final TextEditingController bController = TextEditingController();

  double wCalculate(double p, double sigmaWValue, String type) {
    switch (type) {
      case "with":
        return p * 24 * sigmaWValue;
      case "without":
        return p * 24 * (1 - sigmaWValue);
      default:
        return 0.0;
    }
  }

  double profFineCalculate(double w, double b) {
    return w*b;
  }

  double trapezoidalRule(double Function(double) f, double a, double b, int n) {
    double h = (b - a) / n; // Width of each trapezoid
    double sum = 0.5 * (f(a) + f(b)); // Start with half the endpoints

    for (int i = 1; i < n; i++) {
      double x = a + i * h;
      sum += f(x);
    }

    return h * sum;
  }

  double calculateP(double pC, double sigma, double b) {
    double x = pC * 0.95;
    double y = pC * 1.05;

    double pdFunction(double p) {
      return exp(-pow(p - pC, 2) / (2 * pow(sigma, 2))) / (sigma * sqrt(2 * pi));
    }

    double sigmaWValue = trapezoidalRule(pdFunction, x, y, 100);

    double w1 = wCalculate(pC, sigmaWValue, "with");
    double prof1 = profFineCalculate(w1, b);
    double w2 = wCalculate(pC, sigmaWValue, "without");
    double fine1 = profFineCalculate(w2, b);

    double pdFunctionUpdated(double p) {
      return exp(-pow(p - pC, 2) / (pow(0.25, 2) * 2)) / (0.25 * sqrt(2 * pi));
    }

    double sigmaWValueUpdated = trapezoidalRule(pdFunctionUpdated, x, y, 100);

    double w3 = wCalculate(pC, sigmaWValueUpdated, "with");
    double prof2 = profFineCalculate(w3, b);
    double w4 = wCalculate(pC, sigmaWValueUpdated, "without");
    double fine2 = profFineCalculate(w4, b);

    double profitValue = prof2 - fine2;
    return profitValue;
  }


  void doCalculations() {
    final List<double?> values = [
      double.tryParse(pCController.text),
      double.tryParse(sigmaController.text),
      double.tryParse(bController.text)
    ];

    if (values.contains(null)) {
      setState(() {
        resultText = "";
        errorText = "Будь ласка, введіть всі значення";
      });
      return;
    }

    final double pC = values[0]!;
    final double sigma = values[1]!;
    final double b = values[2]!;


    final double profitValue = double.parse(calculateP(pC, sigma, b).toStringAsFixed(2));

    setState(() {
      errorText = "";
      resultText= "Прибуток становитиме $profitValue";
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
              controller: pCController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Середньодобова потужність, МВт'),
            ),
            TextField(
              controller: sigmaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Середньоквадратичне відхилення (МВт)'),
            ),
            TextField(
              controller: bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вартість електроенергії'),
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
