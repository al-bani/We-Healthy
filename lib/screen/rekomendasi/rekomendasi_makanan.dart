import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:we_healthy/models/makanan_day_model.dart';
import 'package:we_healthy/models/nutriens_model.dart';
import 'package:we_healthy/models/user_model.dart';
import 'package:we_healthy/models/user_week_model.dart';
import 'package:we_healthy/models/workout_day_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/services/wehealthy_services.dart';
import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';

class RekomendasiMakanan extends StatefulWidget {
  const RekomendasiMakanan({super.key});

  @override
  State<RekomendasiMakanan> createState() => _RekomendasiMakananState();
}

class _RekomendasiMakananState extends State<RekomendasiMakanan> {
  late String uid;
  late String periodisasi;
  late String hari;
  bool loading = true;
  bool loadingButton = false;
  bool visibilityDone = false;
  List<NutriensModel> carbsList = [];
  List<NutriensModel> proteinList = [];
  List<NutriensModel> fatsList = [];
  late double caloriesTotal;
  final TextEditingController _textFieldController = TextEditingController();
  WehealthyLogic whl = WehealthyLogic();
  DataService ds = DataService();

  Future<void> dialogNotif(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pemberitahuan"),
            content: const Text(
                "Update Berat badan berhasil, anda akan diarahkan ke homepage, untuk melihat progress silahkan pergi ke page statistik"),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK !'),
                onPressed: () async {
                  Navigator.pushNamed(context, 'home_screen',
                      arguments: {'userId': uid});
                },
              ),
            ],
          );
        });
  }

  Future<void> dialogUpdate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Berat badan Anda'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration:
                  const InputDecoration(suffix: Text('kg'), hintText: "0"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    loadingButton = false;
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Lanjutkan'),
                onPressed: () async {
                  int statusInsertUserWeek = await insertUserWeek();

                  if (statusInsertUserWeek == 1) {
                    dialogNotif(context);
                  } else {
                    setState(() {
                      loadingButton = false;
                    });
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> dialogConfirm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pemberitahuan"),
            content: const Text("Update berat badan anda"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                  dialogUpdate(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  Future<int> insertUserWeek() async {
    List<UserWeekModel> checkingUserWeek = [];
    List tempUserWeek = [];
    String bb = _textFieldController.text;

    tempUserWeek = jsonDecode(await ds.selectWhere(
        token, project, 'user_week', appid, 'user_id', uid));

    checkingUserWeek =
        tempUserWeek.map((e) => UserWeekModel.fromJson(e)).toList();
    List<int>? userWeek = [];
    userWeek = checkingUserWeek
        .map((e) => e.week)
        .map(int.tryParse)
        .cast<int>()
        .toList();
    int maxWeek =
        userWeek.reduce((value, element) => value > element ? value : element);
    int week = maxWeek + 1;

    List response =
        jsonDecode(await ds.insertUserWeek(appid, uid, bb, week.toString()));
    List<UserWeekModel> userWeekInsert =
        response.map((e) => UserWeekModel.fromJson(e)).toList();
    if (userWeekInsert.length == 1) {
      await ds.removeAll(token, project, 'makanan_day', appid);

      bool updateUserData =
          await whl.updateUserData(uid, double.parse(bb), 0, 0, 0);
      if (updateUserData) {
        print('userData Update : $updateUserData');
        return 1;
      }
    }
    return 0;
  }

  void selectFoodData() async {
    await Future.delayed(Duration(seconds: 3));
    List carbsTempData = [];
    List proteinTempData = [];
    List fatsTempData = [];
    List<NutriensModel> carbsListTemp = [];
    List<NutriensModel> proteinListTemp = [];
    List<NutriensModel> fatsListTemp = [];

    carbsTempData = jsonDecode(
        await ds.selectWhere(token, project, 'carbs', appid, 'user_id', uid));

    proteinTempData = jsonDecode(
        await ds.selectWhere(token, project, 'protein', appid, 'user_id', uid));

    fatsTempData = jsonDecode(
        await ds.selectWhere(token, project, 'fat', appid, 'user_id', uid));

    carbsListTemp =
        carbsTempData.map((e) => NutriensModel.fromJson(e)).toList();

    proteinListTemp =
        proteinTempData.map((e) => NutriensModel.fromJson(e)).toList();

    fatsListTemp = fatsTempData.map((e) => NutriensModel.fromJson(e)).toList();

    carbsList = carbsListTemp.where((e) => e.hari == hari).toList();
    proteinList = proteinListTemp.where((e) => e.hari == hari).toList();
    fatsList = fatsListTemp.where((e) => e.hari == hari).toList();

    setState(() {
      caloriesTotal = (double.parse(carbsList[0].kalori) +
              double.parse(proteinListTemp[0].kalori) +
              double.parse(fatsListTemp[0].kalori))
          .floorToDouble();
      loading = false;
    });
  }

  Future<int> insertMakananData() async {
    try {
      List response = jsonDecode(await ds.insertMakananDay(
          appid, uid, '1', hari, caloriesTotal.toString()));
      List<MakananDayModel> makananData =
          response.map((e) => MakananDayModel.fromJson(e)).toList();
      if (makananData.length == 1) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
    }
    return 0;
  }

  void selectMakananDone() async {
    await Future.delayed(Duration(seconds: 3));
    List tempMakananDone = [];
    List<MakananDayModel> makananDone = [];

    tempMakananDone = jsonDecode(await ds.selectWhere(
        token, project, 'makanan_day', appid, 'hari', hari));
    makananDone =
        tempMakananDone.map((e) => MakananDayModel.fromJson(e)).toList();

    if (makananDone.isNotEmpty) {
      if (makananDone.every((element) => element.user_id == uid)) {
        setState(() {
          visibilityDone = true;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectFoodData();
    selectMakananDone();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      uid = args['userId'];
      periodisasi = args['periodisasi'];
      hari = args['hari'];
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi_hari_makan',
                  arguments: {
                    'periodisasi': args['periodisasi'],
                    'userId': args['userId'],
                    'pilihan': 'makanan'
                  });
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
        title: Image.asset(
          'assets/wehealty.png',
          fit: BoxFit.contain,
          height: 170,
        ),
      ),
      backgroundColor: Color(0xFFE6E7EB),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/makanan.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                            height: 200,
                          ),
                        ),
                        Text(
                          "Total Kalori makanan $caloriesTotal kcal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(5, 5),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 5.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Card(
                      child: ExpansionTile(
                        title: Text('Karbohidrat: 35%'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
                            child: ListTile(
                              title: Text(
                                  '${carbsList[0].nama_makanan}: ${carbsList[0].jumlah_sajian}g'),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/icon/food/${carbsList[0].nama_makanan}.png'),
                              ),
                              subtitle: Text('${carbsList[0].kalori} kcal'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      child: ExpansionTile(
                        title: Text('Protein: 30%'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
                            child: ListTile(
                              title: Text(
                                  '${proteinList[0].nama_makanan}: ${proteinList[0].jumlah_sajian}g'),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/icon/food/${proteinList[0].nama_makanan}.png'),
                              ),
                              subtitle: Text('${proteinList[0].kalori} kcal'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      child: ExpansionTile(
                        title: Text('Lemak: 35%'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
                            child: ListTile(
                              title: Text(
                                  '${fatsList[0].nama_makanan}: ${fatsList[0].jumlah_sajian}g'),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/icon/food/${fatsList[0].nama_makanan}.png'),
                              ),
                              subtitle: Text('${fatsList[0].kalori} kcal'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    visibilityDone
                        ? Text(
                            "Anda telah menyelesaikan rekomendasi makanan hari ini",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        : loadingButton
                            ? CircularProgressIndicator()
                            : ElevatedButton.icon(
                                onPressed: () async {
                                  setState(() {
                                    loadingButton = true;
                                  });

                                  if (hari == '7') {
                                    dialogConfirm(context);
                                  } else {
                                    int statusMakananInsert =
                                        await insertMakananData();

                                    if (statusMakananInsert == 1) {
                                      Navigator.pushNamed(
                                          context, 'rekomendasi_hari_makan',
                                          arguments: {
                                            'periodisasi': args['periodisasi'],
                                            'userId': args['userId'],
                                            'pilihan': 'makanan'
                                          });
                                    } else {
                                      setState(() {
                                        loadingButton = false;
                                      });
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white, // Warna ikon
                                ),
                                label: Text(
                                  'Selesai',
                                  style: TextStyle(
                                    color: Colors.white, // Warna teks
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .blue, // Warna latar belakang tombol
                                ),
                              ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: bottomNavigationBar(userId: uid),
    );
  }
}
