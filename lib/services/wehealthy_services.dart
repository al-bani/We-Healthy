import 'dart:math';

class WehealthyLogic {
  double bmi(double kg, double cm) {
    double? m = cm / 100;
    double? nilaiBmi = kg / (pow(m, 2));

    return nilaiBmi;
  }

  double bmr(String gender, int umur, double cm, double kg) {
    double? nilaiBmr;

    if (gender == "Pria") {
      nilaiBmr = (10 * kg) + (6.25 * cm) - (5 * umur) + 5;
    } else {
      nilaiBmr = (10 * kg) + (6.25 * cm) - (5 * umur) - 161;
    }
    return nilaiBmr;
  }

  double tdee(double bmr, double met) {
    double? nilaiTdee = bmr * met;

    return nilaiTdee;
  }
}
