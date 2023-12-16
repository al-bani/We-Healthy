import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_healthy/models/user_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/services/rest_api.dart';
import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  String location = "loading...";
  String weatherCondition = "loading...";
  double celcius = 0;
  RestApi rsa = RestApi();
  List<UserDataModel> _dataUser = [];
  DataService ds = DataService();
  double _calorieWeekly = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void selectUserData() async {
    final User? user = auth.currentUser;
    String uid = user!.uid;
    List tempData = [];

    tempData = jsonDecode(await ds.selectWhere(
        token, project, "user_data", appid, 'user_id', uid));

    _dataUser = tempData.map((e) => UserDataModel.fromJson(e)).toList();
    _calorieWeekly = double.parse(_dataUser[0].kalori_perhari) * 7;
  }

  void checkDataAPI(
      String checkCondition, double checkCelcius, String checkLocation) {
    if (checkCondition != "loading..." ||
        checkCelcius != 0 ||
        checkLocation != "loading...") {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchDataAPI() async {
    String fetchedLocation = await rsa.getCurrentLocationUser();
    int fetchedIndexAqi = await rsa.getAirPollution();
    double fetchedKelvin = await rsa.getCurrentWeather();

    setState(() {
      if (fetchedIndexAqi == 1) {
        weatherCondition = "Baik";
      } else if (fetchedIndexAqi == 2) {
        weatherCondition = "Cukup baik";
      } else if (fetchedIndexAqi == 3) {
        weatherCondition = "Sedang";
      } else if (fetchedIndexAqi == 4) {
        weatherCondition = "Buruk";
      } else if (fetchedIndexAqi == 5) {
        weatherCondition = "Sangat Buruk";
      }
      location = fetchedLocation;
      celcius = (fetchedKelvin - 273.15).roundToDouble();
      checkDataAPI(weatherCondition, celcius, location);
    });
  }

  @override
  void initState() {
    super.initState();
    selectUserData();
    fetchDataAPI();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: Image.asset(
                    '/logo/logo_blue.png' // Sesuaikan dengan tinggi yang diinginkan
                    ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(
                                    '/cuaca/sun.png'), // Ganti dengan path gambar Anda
                                fit: BoxFit
                                    .cover, // Sesuaikan dengan preferensi desain Anda
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20.0, top: 20.0),
                                            child: Text(
                                              location,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black,
                                                    offset: Offset(1.0, 1.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.0),
                                            child: Text(
                                              '$celcius ' + '°C',
                                              style: TextStyle(
                                                fontSize: 35,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black,
                                                    offset: Offset(1.0, 1.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20.0, bottom: 20.0),
                                            child: Text(
                                              "Kualitas Udara: $weatherCondition",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black,
                                                    offset: Offset(1.0, 1.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: const Icon(
                                        Icons.dangerous,
                                        size: 100,
                                        color: Colors.red,
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Card(
                        color: Color(0xFFfffffff),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                                "Dianjurkan Menggunakan Masker karena cuaca yang buruk dan Menggunakan Sunscreen untuk menjaga Kulit anda"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Card(
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Data Fisik:',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: ListTile(
                                          title: Text(
                                            _dataUser[0].berat_badan,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Kilogram',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: ListTile(
                                          title: Text(
                                            _dataUser[0].tinggi_badan,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Centimer',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${_dataUser[0].bmi}",
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFe0f2f1),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${_dataUser[0].kategori_berat}",
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFe0f2f1),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    "SKOR BMI",
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blueAccent,
                                          onPrimary: Colors.white),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          'detail_bmi',
                                        );
                                      },
                                      child: Text('Detail'))
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Card(
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Kalori Pemeliharaan Anda:',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: ListTile(
                                          title: Text(
                                            '${_dataUser[0].kalori_perhari} kcal',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Kalori per Hari',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: ListTile(
                                          title: Text(
                                            '$_calorieWeekly kcal',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Kalori per Minggu',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              padding: EdgeInsets.only(left: 130, right: 130)),
                          onPressed: () {
                            Navigator.pushNamed(context, 'rekomendasi');
                          },
                          child: Text('Lihat Rekomendasi'))
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(),
          );
  }
}
