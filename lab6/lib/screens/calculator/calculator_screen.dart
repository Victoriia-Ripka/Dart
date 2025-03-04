import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab6/services/calculator_service.dart';
import 'package:lab6/data/ep_input.dart' as data;
import 'package:lab6/screens/components/ep_input_fields.dart' as components;
import 'package:lab6/screens/components/fancy_button.dart';
import 'package:lab6/screens/components/header.dart';
import 'package:lab6/screens/components/title.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback goBack;
  final CalculatorService calculatorService;

  const CalculatorScreen({
    super.key,
    required this.goBack,
    required this.calculatorService,
  });

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late List<data.EPInput> epInputs = List.generate(8, (_) => data.EPInput());
  late List<data.EPInput> epExtraInputs = List.generate(2, (_) => data.EPInput());
  List<double> resultArray = List.filled(14, 0.0);

  static const double allNPh = 2330.0;
  static const double allNPK = 752.0;
  static const double allNPKtg = 657.0;
  static const double allNP2 = 96399.0;

  Future<void> loadJsonFromAssets(String fileName, bool isExtra) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/$fileName');
      final List<dynamic> parsedList = jsonDecode(jsonString);
      final List<data.EPInput> parsedInputs = parsedList.map((e) => data.EPInput.fromJson(e as Map<String, dynamic>)).toList();

      setState(() {
        if (isExtra) {
          epExtraInputs = List.of(parsedInputs); // Робимо копію списку
        } else {
          epInputs = List.of(parsedInputs);
        }
      });
    } catch (e) {
      debugPrint("Error loading JSON file: $e");
    }
  }

  void calculate() {
    try {
      final List<double> NPhList = widget.calculatorService.calculateNPh(epInputs);
      final double NPhSum = widget.calculatorService.calculateSumNPh(NPhList);
      // final List<double> I = widget.calculatorService.calculateI(epInputs);
      // final double sumCount = widget.calculatorService.calculateSumCount(epInputs);
      final double KV = widget.calculatorService.calculateGroupUtilizationCoeff(epInputs);
      final double nE = widget.calculatorService.calculateEfCount(NPhSum, epInputs).toDouble();
      const double Kp = 1.25;
      final double Pp = widget.calculatorService.calculatePp(Kp, epInputs);
      final int nERounded = nE.round(); // Rounds the double to the nearest int
      final double Qp = widget.calculatorService.calculateQp(nERounded, epInputs);
      final double Sp = widget.calculatorService.calculateSp(Pp, Qp);
      final double Ip = widget.calculatorService.calculateIp(
        Pp,
        double.tryParse(epInputs[3].voltage) ?? 1.0,
      );

      final double allKV = allNPK / allNPh;
      final double allNe = pow(allNPh, 2) / allNP2;
      const double allKp = 0.7;
      final double allPp = allKp * allNPK;
      final double allQp = allKp * allNPKtg;
      final double allSp = sqrt(pow(allPp, 2) + pow(allQp, 2));
      final double allIp = allPp / (double.tryParse(epInputs[3].voltage) ?? 1.0);

      setState(() {
        resultArray = [
          KV,
          nE,
          Kp,
          Pp,
          Qp,
          Sp,
          Ip,
          allKV,
          allNe,
          allKp,
          allPp,
          allQp,
          allSp,
          allIp,
        ].map((e) => double.parse(e.toStringAsFixed(2))).toList();
      });
    } catch (e) {
      debugPrint("Error during calculation: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomHeader(),
          const SizedBox(height: 10),
          const CustomTitle(text: "Завдання 1"),
          const SizedBox(height: 10),
          const CustomTitle(text: "Калькулятор розрахунку електричних навантажень об’єктів."),
          const SizedBox(height: 20),

          ...epInputs.asMap().entries.map((entry) {
            int index = entry.key;
            data.EPInput epInput = entry.value;
            return Column(
              children: [
                Text("ЕП #${index + 1}"),
                components.EPInputFields(
                  epInput: epInput as components.EPInput2,
                  onUpdate: (updatedInput) => setState(() => epExtraInputs[index] = updatedInput as data.EPInput),
                ),
                const SizedBox(height: 10),
              ],
            );
          }),

          const SizedBox(height: 20),
          FancyButton(
            text: "Заповнити поля",
            onClick: () => loadJsonFromAssets("testInputs.json", false),
          ),

          const SizedBox(height: 20),
          ...epExtraInputs.asMap().entries.map((entry) {
            int index = entry.key;
            data.EPInput epInput = entry.value;
            return Column(
              children: [
                Text("Крупні ЕП #${index + 1}"),
                components.EPInputFields(
                  epInput: epInput as components.EPInput2,
                  onUpdate: (updatedInput) => setState(() => epExtraInputs[index] = updatedInput as data.EPInput),
                ),
                const SizedBox(height: 10),
              ],
            );
          }),

          const SizedBox(height: 20),
          FancyButton(
            text: "Заповнити поля",
            onClick: () => loadJsonFromAssets("extraEPdata.json", true),
          ),

          const SizedBox(height: 20),
          FancyButton(
            text: "Розрахувати",
            onClick: calculate,
          ),

          const SizedBox(height: 20),
          FancyButton(
            text: "Повернутися назад",
            onClick: widget.goBack,
          ),

          if (resultArray.isNotEmpty && resultArray[0] > 0.0) ...[
            const SizedBox(height: 16),
            const Text("Для заданого складу ЕП та їх характеристик цехової мережі силове навантаження становитиме",
                style: TextStyle(fontSize: 16)),
            ...List.generate(resultArray.length, (index) {
              return Text(
                _getResultText(index, resultArray[index]),
                style: const TextStyle(fontSize: 16),
              );
            }),
            const SizedBox(height: 50),
          ],
        ],
      ),
    );
  }

  String _getResultText(int index, double value) {
    List<String> labels = [
      "Груповий коефіцієнт використання для ШР1=ШР2=ШР3",
      "Ефективна кількість ЕП для ШР1=ШР2=ШР3",
      "Розрахунковий коефіцієнт активної потужності для ШР1=ШР2=ШР3",
      "Розрахункове активне навантаження для ШР1=ШР2=ШР3",
      "Розрахункове реактивне навантаження для ШР1=ШР2=ШР3",
      "Повна потужність для ШР1=ШР2=ШР3",
      "Розрахунковий груповий струм для ШР1=ШР2=ШР3",
      "Коефіцієнти використання цеху в цілому",
      "Ефективна кількість ЕП цеху в цілому",
      "Розрахунковий коефіцієнт активної потужності цеху в цілому",
      "Розрахункове активне навантаження на шинах 0,38 кВ ТП",
      "Розрахункове реактивне навантаження на шинах 0,38 кВ ТП",
      "Повна потужність на шинах 0,38 кВ ТП",
      "Розрахунковий груповий струм на шинах 0,38 кВ ТП",
    ];
    return "${labels[index]}: $value";
  }
}