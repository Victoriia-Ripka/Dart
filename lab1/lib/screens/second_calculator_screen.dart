import 'package:flutter/material.dart';

class SecondCalculatorScreen extends StatefulWidget {
  @override
  _SecondCalculatorScreenState createState() => _SecondCalculatorScreenState();
}

class _SecondCalculatorScreenState extends State<SecondCalculatorScreen> {
  final TextEditingController h2Controller = TextEditingController();
  final TextEditingController c2Controller = TextEditingController();
  final TextEditingController o2Controller = TextEditingController();
  final TextEditingController s2Controller = TextEditingController();
  final TextEditingController q2Controller = TextEditingController();
  final TextEditingController v2Controller = TextEditingController();
  final TextEditingController w2Controller = TextEditingController();
  final TextEditingController a2Controller = TextEditingController();

  String errorText = '';
  String resultText = '';
  List<List<String>> tableData = [];

  List<double> roundValues(List<double> values) {
    return values.map((value) => double.parse(value.toStringAsFixed(2))).toList();
  }

  List<double> calculateWorkFuelPercentage(double burnWorkCoeffValue, double dryWorkCoeffValue, double c2Value, double h2Value, double o2Value, double s2Value, double a2Value, double v2Value) {
    return roundValues([
      c2Value * burnWorkCoeffValue,
      h2Value * burnWorkCoeffValue,
      o2Value * burnWorkCoeffValue,
      s2Value * burnWorkCoeffValue,
      a2Value * dryWorkCoeffValue,
      v2Value * dryWorkCoeffValue
    ]);
  }

  bool checkRequirements(double h, double c, double o, double s) {
    return (h + c + s + o) == 100.0;
  }

  void doCalculations() {
    final List<double?> values = [
      double.tryParse(h2Controller.text),
      double.tryParse(c2Controller.text),
      double.tryParse(o2Controller.text),
      double.tryParse(s2Controller.text),
      double.tryParse(q2Controller.text),
      double.tryParse(v2Controller.text),
      double.tryParse(w2Controller.text),
      double.tryParse(a2Controller.text),
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
    final double o = values[2]!;
    final double s = values[3]!;
    final double q = values[4]!;
    final double v = values[5]!;
    final double w = values[6]!;
    final double a = values[7]!;

    if (!checkRequirements(h, c, o, s)) {
      setState(() {
        errorText = "Сума відсоткового складу палива (H + C + S + O) повинна == 100";
      });
      return;
    }

    double whc = (100 - w - a) / 100;
    double burnWorkCoeffValue = double.parse(whc.toStringAsFixed(2));
    double whc2 = (100 - a) / 100;
    double dryWorkCoeffValue = double.parse(whc2.toStringAsFixed(2));
    double hc = q * burnWorkCoeffValue - 0.025 * w;
    double heatCombustionValue = double.parse(hc.toStringAsFixed(2));

    List<double> workFuelPercentageValue = calculateWorkFuelPercentage(burnWorkCoeffValue, dryWorkCoeffValue, c, h, o, s, a, v);

    setState(() {
      errorText = '';
      resultText = "Нижча теплота згоряння: ${heatCombustionValue.toStringAsFixed(2)} кДж/кг.";
      tableData = [
        ["C", c.toString(), workFuelPercentageValue[0].toString()],
        ["H", h.toString(), workFuelPercentageValue[1].toString()],
        ["O", o.toString(), workFuelPercentageValue[2].toString()],
        ["S", s.toString(), workFuelPercentageValue[3].toString()],
        ["Ash", a.toString(), workFuelPercentageValue[4].toString()],
        ["W", w.toString(), "-"],
        ["V", v.toString(), workFuelPercentageValue[5].toString()]
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Другий калькулятор")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: c2Controller, decoration: const InputDecoration(labelText: "C, %")),
            TextField(controller: h2Controller, decoration: const InputDecoration(labelText: "H, %")),
            TextField(controller: o2Controller, decoration: const InputDecoration(labelText: "O, %")),
            TextField(controller: s2Controller, decoration: const InputDecoration(labelText: "S, %")),
            TextField(controller: q2Controller, decoration: const InputDecoration(labelText: "Q (кДж/кг)")),
            TextField(controller: w2Controller, decoration: const InputDecoration(labelText: "W, %")),
            TextField(controller: a2Controller, decoration: const InputDecoration(labelText: "A, %")),
            TextField(controller: v2Controller, decoration: const InputDecoration(labelText: "V (мг/кг)")),
            ElevatedButton(onPressed: doCalculations, child: const Text("Calculate")),
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
                    DataColumn(label: Text('Компонент')),
                    DataColumn(label: Text('Значення, %')),
                    DataColumn(label: Text('Горюча маса, %')),
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