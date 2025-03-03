import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class CalculatorService {
  // Helper function to round a number up to the nearest base
  int roundUpToNearest(double number, int base) {
    return (ceil(number / base) * base).toInt();
  }

  // Helper function to find a cable by conductor and type
  Map<String, dynamic>? findCableByConductorAndType(
      List<dynamic> jsonArray, String conductor, String type) {
    for (var cable in jsonArray) {
      if (cable['conductor'] == conductor && cable['type'] == type) {
        return cable;
      }
    }
    return null;
  }

  // Helper function to find the Jek value based on the time input
  double findJekValue(Map<String, dynamic> selectedCable, double timeInput) {
    var timeData = selectedCable['time'];
    var ranges = ["1000-3000", "3000-5000", "5000-10000"];
    for (var range in ranges) {
      var parts = range.split("-").map((e) => int.parse(e)).toList();
      if (timeInput >= parts[0] && timeInput <= parts[1]) {
        return timeData[range].toDouble();
      }
    }
    throw Exception("No matching time range found for time input: $timeInput");
  }

  // Function to load cable data from assets
  Future<List<dynamic>> loadCableData() async {
    try {
      // Load the cable data from the assets folder
      String jsonString = await rootBundle.loadString('assets/cable_data.json');
      return jsonDecode(jsonString);
    } catch (e) {
      throw Exception("The file cable_data.json was not found in the assets folder.");
    }
  }

  // Function to calculate the compatibility of cables
  Future<int> calculateCablesCompatibility(
      String conductorInput, String cableTypeInput, double timeInput) async {
    final cableData = await loadCableData();

    const double U = 10.0;
    const double IK = 2.5 * 1000;
    const double tF = 2.5;
    const double N = 2.0 * 1000;
    const double SM = 1300.0;

    var selectedCable =
    findCableByConductorAndType(cableData, conductorInput, cableTypeInput);
    var Jek = selectedCable != null ? findJekValue(selectedCable, timeInput) : 0.0;

    double IM = (SM / 2) / (sqrt(3.0) * U);
    double Sek = IM / Jek;

    const int CT = 92;
    double Smin = IK * sqrt(tF) / CT;
    int result = roundUpToNearest(Smin, 10);

    return result;
  }

  // Function to determine the current for specific parameters
  double determinateCurrent(
      {double u = 10.5, double sk = 200.0, double sNomt = 6.3}) {
    double Xc = pow(u, 2) / sk;
    double Xt = u / 100 * (pow(u, 2) / sNomt);
    double X = Xc + Xt;
    double Ip0 = u / (sqrt(3.0) * X);

    return double.parse(Ip0.toStringAsFixed(2));
  }

  // Function to determine substation current based on various parameters
  Future<List<double>> determinateSubstationCurrent() async {
    const uAT1 = 750.0;
    const uAT2 = 330.0;
    const u = [6, 10, 35, 110];

    const Rsn110 = 10.65;
    const Xcn110 = 24.02;
    const Rsmin110 = 34.88;
    const Xcmin110 = 65.68;

    const sNomt = 6.3;
    const uKMax = 11.1;
    const uVn = 115.0;

    double xT = (uKMax * pow(uVn, 2)) / (100 * sNomt);

    double rSH = Rsn110;
    double xSH = Xcn110 + xT;
    double zSH = sqrt(pow(rSH, 2) + pow(xSH, 2));

    double rSHmin = Rsmin110;
    double xSHmin = Xcmin110 + xT;
    double zSHmin = sqrt(pow(rSHmin, 2) + pow(xSHmin, 2));

    double i3SH = uVn * 1000 / (sqrt(3.0) * zSH);
    double i2SH = i3SH * sqrt(3.0) / 2.0;
    double i3SHmin = uVn * 1000 / (sqrt(3.0) * zSHmin);
    double i2SHmin = i3SHmin * sqrt(3.0) / 2.0;

    double k = pow(uKMax, 2) / pow(uVn, 2);

    double rSHn = rSH * k;
    double xSHn = xSH * k;
    double zSHn = sqrt(pow(rSHn, 2) + pow(xSHn, 2));

    double rSHnmin = rSHmin * k;
    double xSHnmin = xSHmin * k;
    double zSHnmin = sqrt(pow(rSHnmin, 2) + pow(xSHnmin, 2));

    double i3SHn = uKMax * 1000 / (sqrt(3.0) * zSHn);
    double i2SHn = i3SHn * sqrt(3.0) / 2.0;
    double i3SHnmin = uKMax * 1000 / (sqrt(3.0) * zSHnmin);
    double i2SHnmin = i3SHnmin * sqrt(3.0) / 2.0;

    const l = 12.37;
    const r0 = 0.64;
    const x0 = 0.363;
    double rL = l * r0;
    double xL = l * x0;

    double rSum = rL + rSHn;
    double xSum = xL + xSHn;
    double zSum = sqrt(pow(rSum, 2) + pow(xSum, 2));
    double rSumMin = rL + rSHnmin;
    double xSumMin = xL + xSHnmin;
    double zSumMin = sqrt(pow(rSumMin, 2) + pow(xSumMin, 2));

    double i3LN = uKMax * 1000 / (sqrt(3.0) * zSum);
    double i2LN = i3LN * sqrt(3.0) / 2;
    double i3LNmin = uKMax * 1000 / (sqrt(3.0) * zSumMin);
    double i2LNmin = i3LNmin * sqrt(3.0) / 2;

    return [
      double.parse(i3LN.toStringAsFixed(2)),
      double.parse(i2LN.toStringAsFixed(2)),
      double.parse(i3LNmin.toStringAsFixed(2)),
      double.parse(i2LNmin.toStringAsFixed(2)),
    ];
  }

  ceil(double d) {
    return d == d.toInt() ? d.toInt() : d.toInt() + 1;
  }
}

Future<List<dynamic>> loadCableData() async {
  try {
    // Load JSON file from assets
    String jsonString = await rootBundle.loadString('assets/cable_data.json');
    return jsonDecode(jsonString);
  } catch (e) {
    throw Exception("The file cable_data.json was not found in the assets folder.");
  }
}