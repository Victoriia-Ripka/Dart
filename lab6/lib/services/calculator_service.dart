import 'dart:math';
// import '../data/ep_input.dart';
import 'package:lab6/screens/components/ep_input_fields.dart';

class CalculatorService {
  List<double> calculateNPK(List<EPInputModel> epInputs) {
    return epInputs.map((input) {
      final count = int.tryParse(input.count) ?? 0;
      final capacity = double.tryParse(input.capacity) ?? 0.0;
      final coefUsage = double.tryParse(input.coefUsage) ?? 0.0;
      return count.toDouble() * capacity * coefUsage;
    }).toList();
  }

  double calculatePKTgSum(List<EPInputModel> epInputs) {
    final nPK = calculateNPK(epInputs);
    final kptg = epInputs.asMap().map((index, input) {
      final coeffReactPower = double.tryParse(input.coeffReactPower) ?? 0.0;
      return MapEntry(index, coeffReactPower * nPK[index]);
    }).values.toList();

    return kptg.sum();
  }

  List<double> calculateNPh(List<EPInputModel> epInputs) {
    return epInputs.map((input) {
      final count = int.tryParse(input.count) ?? 0;
      final capacity = double.tryParse(input.capacity) ?? 0.0;
      return count * capacity;
    }).toList();
  }

  double calculateSumNPh(List<double> NPhList) {
    return NPhList.sum();
  }

  List<double> calculateI(List<EPInputModel> epInputs) {
    return epInputs.map((input) {
      final count = int.tryParse(input.count) ?? 0;
      final capacity = double.tryParse(input.capacity) ?? 0.0;
      final voltage = double.tryParse(input.voltage) ?? 0.0;
      final coeffPower = double.tryParse(input.coeffPower) ?? 0.0;
      final coeffUsefulAct = double.tryParse(input.coeffUsefulAct) ?? 0.0;

      // Avoid division by zero
      if (voltage == 0.0 || coeffPower == 0.0 || coeffUsefulAct == 0.0) {
        return 0.0;
      } else {
        final NPh = count * capacity;
        return NPh / (sqrt(3.0) * voltage * coeffPower * coeffUsefulAct);
      }
    }).toList();
  }

  int calculateSumCount(List<EPInputModel> epInputs) {
    return epInputs.fold(0, (sum, input) => sum + (int.tryParse(input.count) ?? 0));
  }

  double calculateGroupUtilizationCoeff(List<EPInputModel> epInputs) {
    final nPK = calculateNPK(epInputs);
    final nP = epInputs.map((input) {
      final count = int.tryParse(input.count) ?? 0;
      final capacity = double.tryParse(input.capacity) ?? 0.0;
      return count * capacity;
    }).toList();

    return nPK.sum() / nP.sum();
  }

  int calculateEfCount(double NPh, List<EPInputModel> epInputs) {
    final sum = epInputs.map((input) {
      final count = int.tryParse(input.count) ?? 0;
      final capacity = double.tryParse(input.capacity) ?? 0.0;
      return count * pow(capacity, 2);
    }).toList();

    final result = (pow(NPh, 2) / sum.fold(0.0, (sum, value) => sum + value)).round() + 1;
    return result;
  }

  double calculatePp(double Kp, List<EPInputModel> epInputs) {
    final nPK = calculateNPK(epInputs);
    return Kp * nPK.sum();
  }

  double calculateQp(int en, List<EPInputModel> epInputs) {
    final kptg = calculatePKTgSum(epInputs);
    if (en <= 10) {
      return kptg * 1.1;
    } else {
      return kptg;
    }
  }

  double calculateSp(double Pp, double Qp) {
    return sqrt(pow(Pp, 2) + pow(Qp, 2));
  }

  double calculateIp(double Pp, double Up) {
    return Pp / Up;
  }
}

// Helper extension to calculate sum for List<double> in Dart
extension SumList on List<double> {
  double sum() => reduce((a, b) => a + b);
}