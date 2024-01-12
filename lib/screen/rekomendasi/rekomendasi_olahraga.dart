import 'package:flutter/material.dart';
import 'package:we_healthy/models/user_week_model.dart';
import 'package:we_healthy/models/workout_day_model.dart';
import 'package:we_healthy/services/wehealthy_services.dart';
import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';
import 'package:we_healthy/models/workout_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'dart:convert';

class RekomendasiOlahraga extends StatefulWidget {
  const RekomendasiOlahraga({super.key});

  @override
  State<RekomendasiOlahraga> createState() => _RekomendasiOlahragaState();
}

class _RekomendasiOlahragaState extends State<RekomendasiOlahraga> {
  bool _loading = true;
  late String uid;
  late String periodisasi;
  late String day;
  late List<double> kalori = [];
  late List<int> repetisi = [];
  late List<String> nama = [];
  int bulking = 3;
  int maintenance = 4;
  int cutting = 5;
  int setExercise = 0;
  double caloriesBurned = 0;
  bool visibilityDone = false;
  bool loading = true;
  bool loadingButton = false;
  DataService ds = DataService();
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectWorkoutUser();
    selectWorkoutDone();
  }

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
    WehealthyLogic whl = WehealthyLogic();
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
      await ds.removeAll(token, project, 'workout_day', appid);
      bool updateUserData =
          await whl.updateUserData(uid, double.parse(bb), 0, 0, 0);

      if (updateUserData) {
        return 1;
      }
    }
    return 0;
  }

  void insertOlahragaData() async {
    try {
      List response = jsonDecode(await ds.insertWorkoutDay(
          appid, uid, day, '1', caloriesBurned.toString()));
      List<WorkoutDayModel> workoutData =
          response.map((e) => WorkoutDayModel.fromJson(e)).toList();
      if (workoutData.length == 1) {
        Navigator.pushNamed(context, 'rekomendasi_hari_olahraga', arguments: {
          'periodisasi': periodisasi,
          'userId': uid,
          'pilihan': 'olahraga'
        });
      } else {
        setState(() {
          loadingButton = false;
        });
        print(response);
      }
    } catch (e) {}
  }

  void selectWorkoutDone() async {
    await Future.delayed(Duration(seconds: 3));
    List tempWorkoutDone = [];
    List<WorkoutDayModel> workoutDone = [];

    tempWorkoutDone = jsonDecode(await ds.selectWhere(
        token, project, 'workout_day', appid, 'hari', day));
    workoutDone =
        tempWorkoutDone.map((e) => WorkoutDayModel.fromJson(e)).toList();

    if (workoutDone.isNotEmpty) {
      if (workoutDone.every((element) => element.user_id == uid)) {
        setState(() {
          visibilityDone = true;
        });
      }
    }
  }

  void selectWorkoutUser() async {
    await Future.delayed(Duration(seconds: 3));
    List tempWorkoutData = [];
    List<WorkoutModel> workoutDataFilter = [];

    tempWorkoutData = jsonDecode(await ds.selectWhere(
        token, project, 'list_workout', appid, 'hari', day));

    workoutDataFilter =
        tempWorkoutData.map((e) => WorkoutModel.fromJson(e)).toList();

    for (var i = 0; i < workoutDataFilter.length; i++) {
      nama.add(workoutDataFilter[i].nama_workout);
      repetisi.add(int.parse(workoutDataFilter[i].repetisi));
      if (periodisasi == "Bulking") {
        setExercise = bulking;
        kalori.add((double.parse(workoutDataFilter[i].kalori)) * bulking);
      } else if (periodisasi == "Maintenance") {
        setExercise = maintenance;
        kalori.add((double.parse(workoutDataFilter[i].kalori)) * maintenance);
      } else if (periodisasi == "Cutting") {
        setExercise = cutting;
        kalori.add((double.parse(workoutDataFilter[i].kalori)) * cutting);
      }
    }

    setState(() {
      _loading = false;
    });
  }

  List<String> gambar = [
    'assets/rekomendasi/olahraga/pushup.png',
    'assets/rekomendasi/olahraga/situp.png',
    'assets/rekomendasi/olahraga/pullup.png',
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      uid = args['userId'];
      periodisasi = args['periodisasi'];
      day = args['hari'];
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi_hari_olahraga',
                  arguments: {
                    'periodisasi': args['periodisasi'],
                    'userId': args['userId'],
                    'pilihan': 'olahraga'
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
      body: Center(
        child: _loading
            ? Padding(
                padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Image.asset(
                            'assets/olahraga.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8), // Adjust padding as needed
                            child: Text(
                              'Olahraga',
                              style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: nama.length,
                      itemBuilder: (context, index) {
                        caloriesBurned += kalori[index];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                          child: ListTile(
                            leading: Image.asset('${gambar[index]}'),
                            title: Text('${nama[index]}, $setExercise Set '),
                            subtitle: Text('Repetisi: ${repetisi[index]} kali'),
                            trailing: Text(
                              '${kalori[index]} Kal',
                              style: TextStyle(fontSize: 14),
                            ),
                            // title: Text('Sajian: ${sajian[index]}'),
                            // subtitle: Text('Kalori: ${kalori[index]}'),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  visibilityDone
                      ? Text(
                          "Anda telah menyelesaikan workout ini",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      : loadingButton
                          ? CircularProgressIndicator()
                          : ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  loadingButton = true;
                                });
                                if (day == '7') {
                                  dialogConfirm(context);
                                } else {
                                  insertOlahragaData();
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
                                backgroundColor:
                                    Colors.blue, // Warna latar belakang tombol
                              ),
                            ),
                ],
              ),
      ),
      bottomNavigationBar: bottomNavigationBar(userId: uid),
    );
  }
}
