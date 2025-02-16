import 'package:flutter/material.dart';

class FirstCalculatorScreen extends StatefulWidget {
  const FirstCalculatorScreen({super.key});

  @override
  _FirstCalculatorScreenState createState() => _FirstCalculatorScreenState();
}

class _FirstCalculatorScreenState extends State<FirstCalculatorScreen> {
  final TextEditingController h1Controller = TextEditingController();
  final TextEditingController c1Controller = TextEditingController();
  final TextEditingController s1Controller = TextEditingController();
  final TextEditingController n1Controller = TextEditingController();
  final TextEditingController o1Controller = TextEditingController();
  final TextEditingController w1Controller = TextEditingController();
  final TextEditingController a1Controller = TextEditingController();

  List<double> calculateDryFuelPercentage(
      double workDryCoeffValue,
      double h1Value,
      double c1Value,
      double s1Value,
      double n1Value,
      double o1Value,
      double a1Value) {
    return [
      c1Value * workDryCoeffValue,
      h1Value * workDryCoeffValue,
      s1Value * workDryCoeffValue,
      n1Value * workDryCoeffValue,
      o1Value * workDryCoeffValue,
      a1Value * workDryCoeffValue,
      100 - (c1Value + h1Value + s1Value + n1Value + o1Value + a1Value) * workDryCoeffValue
    ].map((e) => double.parse(e.toStringAsFixed(2))).toList();
  }

  List<double> calculateBurnFuelPercentage(
      double workBurnCoeffValue,
      double h1Value,
      double c1Value,
      double s1Value,
      double n1Value,
      double o1Value) {
    return [
      c1Value * workBurnCoeffValue,
      h1Value * workBurnCoeffValue,
      s1Value * workBurnCoeffValue,
      n1Value * workBurnCoeffValue,
      o1Value * workBurnCoeffValue,
      100 - (c1Value + h1Value + s1Value + n1Value + o1Value) * workBurnCoeffValue
    ].map((e) => double.parse(e.toStringAsFixed(2))).toList();
  }

  String errorText = '';
  String resultText = '';
  List<List<String>> tableData = [];

  bool checkRequirements(double h, double c, double s, double n, double o, double w, double a) {
    return (h + c + s + n + o + w + a) == 100.0;
  }

  void doCalculations() {
    final List<double?> values = [
      double.tryParse(h1Controller.text),
      double.tryParse(c1Controller.text),
      double.tryParse(s1Controller.text),
      double.tryParse(n1Controller.text),
      double.tryParse(o1Controller.text),
      double.tryParse(w1Controller.text),
      double.tryParse(a1Controller.text),
    ];

    if (values.contains(null)) {
      setState(() {
        resultText = "Будь ласка, введіть всі значення";
        errorText = '';
        tableData = [];
      });
      return;
    }

    final double h = values[0]!;
    final double c = values[1]!;
    final double s = values[2]!;
    final double n = values[3]!;
    final double o = values[4]!;
    final double w = values[5]!;
    final double a = values[6]!;

    if (!checkRequirements(h, c, s, n, o, w, a)) {
      setState(() {
        errorText = "Сума відсоткового складу палива повинна дорівнювати 100";
        resultText = '';
        tableData = [];
      });
      return;
    }

    // Перевірка на ділення на нуль
    if (w >= 100) {
      setState(() {
        errorText = "Помилка: вологість не може бути 100% або більше";
        resultText = '';
        tableData = [];
      });
      return;
    }

    if (w + a >= 100) {
      setState(() {
        errorText = "Помилка: сума вологості та золи не може бути 100% або більше";
        resultText = '';
        tableData = [];
      });
      return;
    }

    final double workDryCoeff = 100 / (100 - w);
    final double workBurnCoeff = 100 / (100 - w - a);
    final double heatCombustion = 339 * c + 1030 * h - 108.8 * (o - s) - 25 * w;
    final double dryFuelHeatCombustion = (heatCombustion + 0.025 * w) * workDryCoeff;
    final double burnFuelHeatCombustion = (heatCombustion + 0.025 * w) * workBurnCoeff;

    List<double> dryFuelPercentage = calculateDryFuelPercentage(workDryCoeff, h, c, s, n, o, a);
    List<double> burnFuelPercentage = calculateBurnFuelPercentage(workBurnCoeff, h, c, s, n, o);

    setState(() {
      errorText = '';
      resultText = """
Коефіцієнт переходу від робочої до сухої маси: ${workDryCoeff.toStringAsFixed(2)}
Коефіцієнт переходу від робочої до горючої маси: ${workBurnCoeff.toStringAsFixed(2)}
Нижча теплота згоряння робочої маси: ${heatCombustion.toStringAsFixed(2)} кДж/кг
Нижча теплота згоряння сухої маси: ${dryFuelHeatCombustion.toStringAsFixed(2)} кДж/кг
Нижча теплота згоряння горючої маси: ${burnFuelHeatCombustion.toStringAsFixed(2)} кДж/кг
""";

      tableData = [
        ["C", c.toString(), dryFuelPercentage[0].toString(), burnFuelPercentage[0].toString()],
        ["H", h.toString(), dryFuelPercentage[1].toString(), burnFuelPercentage[1].toString()],
        ["S", s.toString(), dryFuelPercentage[2].toString(), burnFuelPercentage[2].toString()],
        ["N", n.toString(), dryFuelPercentage[3].toString(), burnFuelPercentage[3].toString()],
        ["O", o.toString(), dryFuelPercentage[4].toString(), burnFuelPercentage[4].toString()],
        ["Ash", a.toString(), dryFuelPercentage[5].toString(), "-"]
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: h1Controller, decoration: const InputDecoration(labelText: 'H, %')),
            TextField(controller: c1Controller, decoration: const InputDecoration(labelText: 'C, %')),
            TextField(controller: s1Controller, decoration: const InputDecoration(labelText: 'S, %')),
            TextField(controller: n1Controller, decoration: const InputDecoration(labelText: 'N, %')),
            TextField(controller: o1Controller, decoration: const InputDecoration(labelText: 'O, %')),
            TextField(controller: w1Controller, decoration: const InputDecoration(labelText: 'W, %')),
            TextField(controller: a1Controller, decoration: const InputDecoration(labelText: 'Ash, %')),
            ElevatedButton(onPressed: doCalculations, child: const Text('Calculate')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Назад"),
            ),
            if (errorText.isNotEmpty)
              Text(errorText, style: const TextStyle(color: Colors.red)),

            if (resultText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(resultText, style: const TextStyle(fontSize: 16)),
              ),

            if (tableData.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(label: Text('Елемент')),
                    DataColumn(label: Text('Початковий %')),
                    DataColumn(label: Text('Сухий %')),
                    DataColumn(label: Text('Горючий %')),
                  ],
                  rows: tableData.map((row) {
                    return DataRow(
                      cells: row.map((cell) => DataCell(Text(cell))).toList(),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
