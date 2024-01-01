import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:we_healthy/models/workout_day_model.dart';
import 'package:we_healthy/services/etter_services.dart';

import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';

class RekomendasiHariOlahraga extends StatefulWidget {
  const RekomendasiHariOlahraga({super.key});

  @override
  State<RekomendasiHariOlahraga> createState() =>
      _RekomendasiHariOlahragaState();
}

class _RekomendasiHariOlahragaState extends State<RekomendasiHariOlahraga> {
  List<String> hari = ['1', '2', '3', '4', '5', '6', '7'];
  List<WorkoutDayModel> workoutPerday = [];
  List<String> dayDone = ['0', '0', '0', '0', '0', '0', '0'];
  DataService ds = DataService();
  late String userId;
  bool _loading = true;
  int checkingDayDone = 0;

  Future checkDayWorkout() async {
    await Future.delayed(Duration(seconds: 3));
    List tempWorkoutPerday = [];
    List<String> tempDayDone = [];

    tempWorkoutPerday = jsonDecode(await ds.selectWhere(
        token, project, "workout_day", appid, 'user_id', userId));
    workoutPerday =
        tempWorkoutPerday.map((e) => WorkoutDayModel.fromJson(e)).toList();
    tempDayDone = workoutPerday.map((item) => item.hari).toList();

    if (tempDayDone.every((element) => hari.contains(element))) {
      checkingDayDone = 1;
    }

    setState(() {
      dayDone.replaceRange(0, tempDayDone.length, tempDayDone);

      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDayWorkout();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      userId = args['userId'];
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi_pilihan', arguments: {
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
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/fotohari.png',
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: hari.length,
                      itemBuilder: (context, index) {
                        final item = hari[index];
                        checkingDayDone = 0;
                        if (dayDone.contains(item)) {
                          checkingDayDone = 1;
                        }
                        if (item == '1' || item == '4' || item == '6') {
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.fitness_center),
                              title: Text(
                                "hari $item (libur latihan)",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                          );
                        } else {
                          if (checkingDayDone == 1) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'rekomendasi_olahraga',
                                      arguments: {
                                        'periodisasi': args['periodisasi'],
                                        'userId': args['userId'],
                                        'pilihan': 'olahraga',
                                        'hari': item
                                      });
                                },
                                leading: Icon(Icons.fitness_center),
                                trailing: Icon(Icons.check),
                                title: Text(
                                  "hari $item",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            );
                          } else {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'rekomendasi_olahraga',
                                      arguments: {
                                        'periodisasi': args['periodisasi'],
                                        'userId': args['userId'],
                                        'pilihan': 'olahraga',
                                        'hari': item
                                      });
                                },
                                leading: Icon(Icons.fitness_center),
                                title: Text(
                                  "hari $item",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: bottomNavigationBar(userId: userId),
    );
  }
}
