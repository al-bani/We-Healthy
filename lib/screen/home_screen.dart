import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:we_healthy/models/user_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/services/rest_api.dart';
import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  String _calorieWeekly = ' ';
  String userId = 'null';
  final FirebaseAuth auth = FirebaseAuth.instance;
  String weather = 'loading...';
  String caloriePerDay = ' ';
  String airPolution = 'loading...';
  String textNotificationCelciusUser = 'loading...';
  String textNotificationAqiUser = 'loading...';

  String setImageWeather(double code) {
    print("is here 12");
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
    await Future.delayed(Duration(seconds: 3));
    List tempData = [];

    tempData = jsonDecode(await ds.selectWhere(
        token, project, "user_data", appid, 'user_id', userId));

    _dataUser = tempData.map((e) => UserDataModel.fromJson(e)).toList();

    double tempCalorie = double.parse(_dataUser[0].kalori_perhari);
    _calorieWeekly = NumberFormat("#,##0.###").format(tempCalorie * 7);
    caloriePerDay = NumberFormat("#,##0.###").format(tempCalorie);
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
    List<num> weatherData = await rsa.getCurrentWeather();

    double fetchedKelvin = weatherData[0].toDouble();
    double fetchedWeatherCode = weatherData[0].toDouble();

    setState(() {
      weather = setImageWeather(fetchedWeatherCode);

      if (fetchedIndexAqi == 1) {
        weatherCondition = "Baik";
        airPolution = '1.png';
        textNotificationAqiUser =
            'Udara diluar Sangat baik, Selamat beraktifitas';
      } else if (fetchedIndexAqi == 2) {
        weatherCondition = "Cukup baik";
        airPolution = '2.png';
        textNotificationAqiUser =
            'Udara diluar Cukup baik, Jauhi Spot Lingkungan berpolusi';
      } else if (fetchedIndexAqi == 3) {
        airPolution = '3.png';
        weatherCondition = "Sedang";
        textNotificationAqiUser =
            'Udara diluar cukup untuk melakukan aktifitas, gunakan masker bila perlu';
      } else if (fetchedIndexAqi == 4) {
        airPolution = '4.png';
        weatherCondition = "Buruk";
        textNotificationAqiUser =
            'Udara diluar Buruk, Silahkan gunakan masker untuk menghindari polusi udara';
      } else if (fetchedIndexAqi == 5) {
        airPolution = '5.png';
        weatherCondition = "Sangat Buruk";
        textNotificationAqiUser =
            'Udara diluar Sangat buruk, dianjurkan untuk tetap dirumah dan memakai masker saat diluar rumah';
      }

      location = fetchedLocation;
      celcius = (fetchedKelvin - 273.15).roundToDouble();

      if (celcius < 20) {
        textNotificationCelciusUser =
            'Suhu diluar Tampak Dingin, dianjurkan menggunakan pakaian hangat';
      } else if (celcius >= 20 && celcius <= 29) {
        textNotificationCelciusUser =
            'Suhu diluar tampak Normal, Selamat Beraktifitas';
      } else if (celcius > 29) {
        textNotificationCelciusUser =
            'Suhu diluar tampak panas, dianjurkan menggunakan pakaian yang tidak menyebabkan Panas';
      }
      print("is here 5");

      checkDataAPI(weatherCondition, celcius, location, weather, airPolution);
      print("is here 6");
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

  void locationAllowed() async {
    bool locationRequest = await _handleLocationPermission();
    if (locationRequest) {
      fetchDataAPI();
      selectUserData();
    }
  }

  @override
  void initState() {
    super.initState();

    locationAllowed();
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset('assets/logo/logo_blue.png'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loading
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/cuaca/$weather'), // Ganti dengan path gambar Anda
                                        fit: BoxFit
                                            .cover, // Sesuaikan dengan preferensi desain Anda
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0),
                                                    child: Text(
                                                      '$celcius ' + '°C',
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                        color: Colors.white,
                                                        shadows: [
                                                          Shadow(
                                                            blurRadius: 5.0,
                                                            color: Colors.black,
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0,
                                                        bottom: 20.0),
                                                    child: Text(
                                                      "Kualitas Udara: $weatherCondition",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        shadows: [
                                                          Shadow(
                                                            blurRadius: 5.0,
                                                            color: Colors.black,
                                                            offset: Offset(
                                                                1.0, 1.0),
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
                                                'assets/udara/$airPolution',
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
                                        "$textNotificationCelciusUser dan $textNotificationAqiUser"),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 130,
                                          height: 130,
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
                                          width: 130,
                                          height: 130,
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
                                                    '$caloriePerDay kcal',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
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
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    'Kalori per Minggu',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 11,
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
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'rekomendasi',
                                        arguments: {'userId': userId});
                                  },
                                  child: Text('Lihat Rekomendasi'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(userId: userId),
    );
  }
}
