import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:we_healthy/models/user_model.dart';
import 'package:we_healthy/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/services/wehealthy_services.dart';
import 'package:intl/intl.dart';

class DataFisik extends StatefulWidget {
  final User user;
  const DataFisik({Key? key, required this.user}) : super(key: key);

  @override
  State<DataFisik> createState() => _DataFisikState();
}

class _DataFisikState extends State<DataFisik> {
  final _umurTextController = TextEditingController();
  final _bbTextController = TextEditingController();
  final _tbTextController = TextEditingController();
  late User loggedUser;
  bool loading = false;
  late String? gender;
  late double? met;
  DataService ds = DataService();
  WehealthyLogic calc = WehealthyLogic();
  late Future<DateTime?> selectedAge;
  late int umurPicker;

  @override
  void initState() {
    super.initState();
    loggedUser = widget.user;
  }

  void insertData(var bb, var tb, double metValue, var gender, int umur) async {
    bb = double.parse(bb);
    tb = double.parse(tb);

    double bmi = calc.bmi(bb, tb).roundToDouble();
    double bmr = calc.bmr(gender, umur, tb, bb).roundToDouble();
    double tdee = calc.tdee(bmr, metValue).roundToDouble();
    String userId = loggedUser.uid;

    try {
      List responseWeek = jsonDecode(
          await ds.insertUserWeek(appid, userId, bb.toString(), '1'));

      List<UserDataModel> userData = await calc.insertUserData(
          bmi, bmr, tdee, bb, tb, userId, gender, umur, metValue);

      if (userData.length == 1) {
        Navigator.pushNamed(context, 'home_screen',
            arguments: {'userId': userId});
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        height: MediaQuery.of(context).size.height, // Set tinggi menjadi 100%
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff0055ff),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 70),
              child: Image.asset(
                'logo/logo_white.png',
                width: 300,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 100),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(50.0),
                  ),
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Input Data Fisik",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal,
                              fontSize: 22,
                              color: Color(0xff000000),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Jenis Kelamin',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.person),
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: 'Pria',
                                      child: Text('Laki-laki'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Wanita',
                                      child: Text('Perempuan'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              Expanded(
                                child: TextFormField(
                                  onTap: () => showDialogPicker(context),
                                  controller: _umurTextController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    labelText: 'Umur', // Icon be
                                    hintText: 'Tahun',

                                    filled: true,
                                    prefixIcon: const Icon(Icons.access_time),
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30.0),
                          TextFormField(
                            controller: _bbTextController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: 'Berat Badan', // Icon be
                              hintText: 'Kilogram',
                              filled: true,
                              fillColor: Colors.grey[200],
                              prefixIcon: const Icon(Icons.line_weight),
                              suffix: const Text('kg'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          TextFormField(
                            controller: _tbTextController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: 'Tinggi Badan', // Icon be
                              hintText: 'centimeter',
                              suffix: const Text('cm'),
                              filled: true,
                              prefixIcon: const Icon(Icons.height),
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Kegiatan Sehari-hari',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              filled: true,
                              prefixIcon: const Icon(Icons.work),
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 1.2,
                                child: Text('Melakukan Aktifitas Ringan (berjalan, duduk, tidur)'),
                              ),
                              DropdownMenuItem(
                                value: 1.375,
                                child: Text('Melakukan Pekerjaan ringan (pekerjaan rumah, bekerja dikantor)'),
                              ),
                              DropdownMenuItem(
                                value: 1.55,
                                child: Text('Bekerja dan Berolahraga (Jogging seminggu 1x, bekerja kantor)'),
                              ),
                              DropdownMenuItem(
                                value: 1.725,
                                child: Text('Sering berolahraga dan bekerja yang menguras tenaga'),
                              ),
                              DropdownMenuItem(
                                value: 1.9,
                                child: Text('Bekerja keras atau Seorang atlit'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                met = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          loading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    insertData(
                                        _bbTextController.text,
                                        _tbTextController.text,
                                        met!,
                                        gender,
                                        umurPicker);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[600],
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(140.0, 45.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Lanjutkan'),
                                ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDialogPicker(BuildContext context) {
    var date = DateTime.now();
    DateTime dateLast = DateTime(2013, 12, 31);
    selectedAge = showDatePicker(
      context: context,
      initialDate: dateLast,
      firstDate: DateTime(1901, 1, 1),
      lastDate: dateLast,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    selectedAge.then((value) {
      setState(() {
        if (value == null) return;

        final DateFormat formatter = DateFormat('dd MMMM yyyy');
        final String formattedDate = formatter.format(value);
        umurPicker = DateTime.now().year - value.year;
        if (DateTime.now().month < value.month ||
            (DateTime.now().month == value.month &&
                DateTime.now().day < value.day)) {
          umurPicker--;
        }

        _umurTextController.text = formattedDate;
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
