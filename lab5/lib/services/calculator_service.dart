import 'dart:math';

class CalculatorService {
  List<double> compareReliabilitySystems() {
    // System 1
    int nSwitcher1 = 110;
    int l1 = 10;
    List<int> transformerN1 = [110, 10];
    int inputSwitch1 = 10;
    int accesionN1 = 10;
    int accesionCount1 = 6;

    // System 2
    int nSwitcher2 = 110;
    int l2 = 10;
    List<int> transformerN2 = [110, 10];
    int inputSwitch2 = 10;
    int accesionN2 = 10;
    int accesionCount2 = 6;
    int sectionalSwitchN2 = 10;

    // Constants
    double w_sv = 0.02;

    // Weight and time variables
    List<double> w1 = [0.01, 0.07, 0.015, 0.02, 0.03, 0.03, 0.03, 0.03, 0.03, 0.03];
    List<int> t_v1 = [30, 10, 100, 15, 2, 2, 2, 2, 2, 2];

    // Calculations
    double w_os = w1.reduce((a, b) => a + b);
    double t_vos = w1.asMap().entries.fold(0.0, (sum, entry) {
      return sum + entry.value * t_v1[entry.key];
    }) / w_os;

    double k_aos = w_os * t_vos / 8760;
    double k_pos = 1.2 * 43 / 8760;

    double w_dk = 2 * w_os * (k_aos + k_pos);
    double w_ds = w_dk + w_sv;

    print("Calculator1: w_dk: $w_dk");
    print("Calculator1: w_ds: $w_ds");

    // Round to 4 decimal places
    double roundedValue1 = double.parse(w_dk.toStringAsFixed(4));
    double roundedValue2 = double.parse(w_ds.toStringAsFixed(4));

    return [roundedValue1, roundedValue2];
  }

  String calculateLoses() {
    double z_pera = 23.6;
    double z_perp = 17.6;
    double w = 0.01;
    double t_v = 0.045;

    double t_m = 5.12 * 1000 * 6451;
    double k_p = 0.004;

    // Calculations
    double m_w_neda = w * t_v * t_m;
    double m_w_nedp = k_p * t_m;
    print("Calculator2: m_w_neda: $m_w_neda");
    print("Calculator2: m_w_nedp: $m_w_nedp");

    double m_z_per = z_pera * m_w_neda + z_perp * m_w_nedp;
    return m_z_per.toStringAsFixed(2);
  }
}