import 'dart:math';

class WehealthyLogic {
  double bmi(double kg, double cm) {
    double? m = cm / 100;
    double? nilai_bmi = kg / (pow(m, 2));

    print("2.1");
    return nilai_bmi;
  }

  double bmr(String gender, int umur, double cm, double kg) {
    double? nilai_bmr;

    if (gender == "Pria") {
      nilai_bmr = (10 * kg) + (6.25 * cm) - (5 * umur) + 5;
    } else {
      nilai_bmr = (10 * kg) + (6.25 * cm) - (5 * umur) - 161;
    }
    print("2.2");
    return nilai_bmr;
  }

  double tdee(double bmr, double met) {
    double? nilai_tdee = bmr * met;
    print("2.3");
    return nilai_tdee;
  }
}
