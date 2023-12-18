import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  late String userId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String weather = 'loading...';
  String airPolution = 'loading...';

  String setImageWeather(double code) {
    switch (code) {
      case >= 200 && < 300:
        return 'hujan petir.png';

      case >= 300 && < 400:
        return 'hujan.png';

      case >= 500 && < 600:
        return 'hujan.png';

      case == 800:
        return 'cerah.png';

      case > 800 && <= 804:
        return 'berawan.png';

      default:
        return 'default.png';
    }
  }

  void selectUserData() async {
    final User? user = auth.currentUser;
    String uid = user!.uid;
    List tempData = [];

    setState(() {
      userId = uid;
    });

    tempData = jsonDecode(await ds.selectWhere(
        token, project, "user_data", appid, 'user_id', uid));

    _dataUser = tempData.map((e) => UserDataModel.fromJson(e)).toList();
    _calorieWeekly = double.parse(_dataUser[0].kalori_perhari) * 7;
  }

  void checkDataAPI(String checkCondition, double checkCelcius,
      String checkLocation, String checkWeather, String checkAirPol) {
    if (checkCondition != "loading..." ||
        checkCelcius != 0 ||
        checkLocation != "loading..." ||
        checkWeather != "loading..." ||
        checkAirPol != 'loading...') {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchDataAPI() async {
    String fetchedLocation = await rsa.getCurrentLocationUser();
    int fetchedIndexAqi = await rsa.getAirPollution();
    List<double> weatherData = await rsa.getCurrentWeather();

    double fetchedKelvin = weatherData[0];
    double fetchedWeatherCode = weatherData[1];

    setState(() {
      weather = setImageWeather(fetchedWeatherCode);
      if (fetchedIndexAqi == 1) {
        weatherCondition = "Baik";
        airPolution = '1.png';
      } else if (fetchedIndexAqi == 2) {
        weatherCondition = "Cukup baik";
        airPolution = '2.png';
      } else if (fetchedIndexAqi == 3) {
        airPolution = '3.png';
        weatherCondition = "Sedang";
      } else if (fetchedIndexAqi == 4) {
        airPolution = '4.png';
        weatherCondition = "Buruk";
      } else if (fetchedIndexAqi == 5) {
        airPolution = '5.png';
        weatherCondition = "Sangat Buruk";
      }
      location = fetchedLocation;
      celcius = (fetchedKelvin - 273.15).roundToDouble();
      checkDataAPI(weatherCondition, celcius, location, weather, airPolution);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
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
                                    '/cuaca/$weather'), // Ganti dengan path gambar Anda
                                fit: BoxFit
                                    .cover, // Sesuaikan dengan preferensi desain Anda
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      child: Image.asset(
                                        '/udara/$airPolution',
                                        width: 100,
                                        height: 150,
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
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Kategori",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          "${_dataUser[0].kategori_berat}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
                            Navigator.pushNamed(context, 'rekomendasi',
                                arguments: {'userId': userId});
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
