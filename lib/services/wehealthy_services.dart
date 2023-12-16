import 'dart:convert';
import 'dart:math';

import 'package:we_healthy/models/food_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/utils/config.dart';

class WehealthyLogic {
  DataService ds = DataService();
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

  Future<Map<String, dynamic>> foodList() async {
    List foodCarbs = [];
    List foodProtein = [];
    List foodFats = [];
    List<ListMakananModel> foodlist = [];
    List tempData = [];

    tempData =
        jsonDecode(await ds.selectAll(token, project, 'list_makanan', appid));

    foodlist = tempData.map((e) => ListMakananModel.fromJson(e)).toList();

    for (var i = 0; i < foodlist.length; i++) {
      foodFats.add(foodlist[i].lemak);
      foodProtein.add(foodlist[i].protein);
      foodCarbs.add(foodlist[i].karbohidrat);
    }

    Map<String, dynamic> tripleFoodList = {
      "carbs": foodCarbs,
      "protein": foodFats,
      "fats": foodFats,
    };

    return tripleFoodList;
  }
}
