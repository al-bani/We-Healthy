import 'dart:convert';
import 'dart:math';

import 'package:we_healthy/models/food_model.dart';
import 'package:we_healthy/models/nutriens_model.dart';
import 'package:we_healthy/models/user_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/services/rest_api.dart';
import 'package:we_healthy/utils/config.dart';

class WehealthyLogic {
  DataService ds = DataService();
  RestApi rsa = RestApi();

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
      "protein": foodProtein,
      "fats": foodFats,
    };


    return tripleFoodList;
  }

  Future<int> insertFood(String userId, String day, String periodisasi) async {
    int status = 0;
    Map<String, dynamic> foodList =
        await rsa.fetchDataFood(userId, periodisasi);

    try {
      List responseCarbs = jsonDecode(await ds.insertCarbs(
          appid,
          userId,
          foodList['carbs']['name'],
          foodList['carbs']['serving_size_g'].toString(),
          foodList['carbs']['calories'].toString(),
          day));
      List responseProtein = jsonDecode(await ds.insertProtein(
          appid,
          userId,
          foodList['protein']['name'],
          foodList['protein']['serving_size_g'].toString(),
          foodList['protein']['calories'].toString(),
          day));
      List responseFats = jsonDecode(await ds.insertFat(
          appid,
          userId,
          foodList['fats']['name'],
          foodList['fats']['serving_size_g'].toString(),
          foodList['fats']['calories'].toString(),
          day));

      List<NutriensModel> carbsData =
          responseCarbs.map((e) => NutriensModel.fromJson(e)).toList();
      List<NutriensModel> proteinData =
          responseProtein.map((e) => NutriensModel.fromJson(e)).toList();
      List<NutriensModel> fatsData =
          responseFats.map((e) => NutriensModel.fromJson(e)).toList();

      if (carbsData.length == 1 &&
          proteinData.length == 1 &&
          fatsData.length == 1) {
        return 1;
      }
    } catch (e) {
      print(e);
    }

    return status;
  }

  Future<List<UserDataModel>> insertUserData(
      double bmi,
      double bmr,
      double tdee,
      double bb,
      double tb,
      String userId,
      String gender,
      int umur,
      double metValue) async {
    List<UserDataModel> userData = [];
    late String? kategoriBerat;

    if (bmi <= 18.5) {
      kategoriBerat = "underweight";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      kategoriBerat = "normal";
    } else if (bmi >= 25 && bmi <= 29.9) {
      kategoriBerat = "overweight";
    } else if (bmi >= 30 && bmi <= 34.9) {
      kategoriBerat = "obesitas 1";
    } else if (bmi >= 35 && bmi <= 39.9) {
      kategoriBerat = "obesitas 2";
    } else if (bmi >= 40) {
      kategoriBerat = "obesitas 3";
    }

    try {
      List response = jsonDecode(await ds.insertUserData(
          appid,
          userId,
          gender,
          umur.toString(),
          bb.toString(),
          tb.toString(),
          metValue.toString(),
          tdee.toString(),
          kategoriBerat!,
          bmi.toString()));
      userData = response.map((e) => UserDataModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return userData;
  }

  Future<bool> updateUserData(
    String userId,
    double bb,
    double metValue,
    int umur,
    double tb,
  ) async {
    List<UserDataModel> getUserData = [];
    List tempUserGetData = [];

    tempUserGetData = jsonDecode(await ds.selectWhere(
        token, project, 'user_data', appid, 'user_id', userId));
    getUserData =
        tempUserGetData.map((e) => UserDataModel.fromJson(e)).toList();

    String gender = getUserData[0].gender;
    late String kategoriBerat;

    if (metValue == 0) {
      metValue = double.parse(getUserData[0].kegiatan);
    }

    if (tb == 0) {
      tb = double.parse(getUserData[0].tinggi_badan);
    }

    print('metValue : $tb');

    if (umur == 0) {
      umur = int.parse(getUserData[0].umur);
    }

    print('metValue : $umur');

    double bmiValue = bmi(bb, tb).roundToDouble();
    double bmrValue = bmr(gender, umur, tb, bb).roundToDouble();
    double tdeeValue = tdee(bmrValue, metValue).roundToDouble();

    if (bmiValue <= 18.5) {
      kategoriBerat = "underweight";
    } else if (bmiValue >= 18.5 && bmiValue <= 24.9) {
      kategoriBerat = "normal";
    } else if (bmiValue >= 25 && bmiValue <= 29.9) {
      kategoriBerat = "overweight";
    } else if (bmiValue >= 30 && bmiValue <= 34.9) {
      kategoriBerat = "obesitas 1";
    } else if (bmiValue >= 35 && bmiValue <= 39.9) {
      kategoriBerat = "obesitas 2";
    } else if (bmiValue >= 40) {
      kategoriBerat = "obesitas 3";
    }

    bool updateUserData = await ds.updateWhere(
        'user_id',
        userId,
        'berat_badan~bmi~kalori_perhari~kategori_berat',
        '${bb.toString()}~${bmiValue.toString()}~${tdeeValue.toString()}~$kategoriBerat',
        token,
        project,
        'user_data',
        appid);
    if (updateUserData) {
      return true;
    }

    return false;
  }

  List<double> caloriesCalc(double calorie, String tipe) {
    if (tipe == "Cutting") {
      calorie -= 500;
    } else if (tipe == "Bulking") {
      calorie += 500;
    }

    double fat = ((calorie * 0.25) / 9).roundToDouble();
    double carb = ((calorie * 0.35) / 4).roundToDouble();
    double prot = ((calorie * 0.4) / 4).roundToDouble();

    List<double> caloriesNeeded = [];
    caloriesNeeded.add(fat);
    caloriesNeeded.add(carb);
    caloriesNeeded.add(prot);

    return caloriesNeeded;
  }
}
