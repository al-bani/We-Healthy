import 'package:flutter/material.dart';
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

  bool loading = true;
  DataService ds = DataService();

  @override
  void initState() {
    super.initState();
    selectWorkoutUser();
  }

  void selectWorkoutUser() async {
    await Future.delayed(Duration(seconds: 3));
    List tempWorkoutData = [];
    List<WorkoutModel> workoutDataFilter = [];
    print(day);

    tempWorkoutData = jsonDecode(await ds.selectWhere(
        token, project, 'list_workout', appid, 'hari', day));

    workoutDataFilter =
        tempWorkoutData.map((e) => WorkoutModel.fromJson(e)).toList();

    for (var i = 0; i < workoutDataFilter.length; i++) {
      nama.add(workoutDataFilter[i].nama_workout);
      repetisi.add(int.parse(workoutDataFilter[i].repetisi));
      if (periodisasi == "Bulking") {
        kalori.add((double.parse(workoutDataFilter[i].kalori)) * 3);
      } else if (periodisasi == "Maintenance") {
        kalori.add((double.parse(workoutDataFilter[i].kalori)) * 4);
      } else if (periodisasi == "Cutting") {
        kalori.add((double.parse(workoutDataFilter[i].kalori)) * 5);
      }
    }

    setState(() {
      _loading = false;
    });
  }

  List<String> gambar = [
    '/rekomendasi/olahraga/pushup.png',
    '/rekomendasi/olahraga/situp.png',
    '/rekomendasi/olahraga/pullup.png',
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

    return _loading
        ? const CircularProgressIndicator()
        : Scaffold(
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
                'wehealty.png',
                fit: BoxFit.contain,
                height: 170,
              ),
            ),
            backgroundColor: Color(0xFFE6E7EB),
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Image.asset(
                            'Olahraga.png',
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
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                          child: ListTile(
                            leading: Image.asset('${gambar[index]}'),
                            title: Text('${nama[index]}'),
                            subtitle: Text('Repetisi: ${repetisi[index]}'),
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
                ],
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(),
          );
  }
}
