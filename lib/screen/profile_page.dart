import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:we_healthy/models/user_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/services/wehealthy_services.dart';
import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFffffff), width: 1.0),
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      )),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      )),
);

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FilePickerResult? result;
  List<PlatformFile>? selectedFiles = [];
  bool _loading = false;
  final nama = TextEditingController();
  final user_id = TextEditingController();
  String gender = 'Pria';
  final umur = TextEditingController();
  final berat_badan = TextEditingController();
  final tinggi_badan = TextEditingController();
  final bmi = TextEditingController();
  final kalori_perhari = TextEditingController();
  double kegiatan = 1.2;
  final kategori_berat = TextEditingController();
  bool loadData = false;
  bool loading = true;
  String update_id = '';
  late String userId = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User _currentUser;
  DataService ds = DataService();
  List<UserDataModel> _dataUser = [];
  late Future<DateTime?> selectedAge;
  late int umurPicker;
  WehealthyLogic whl = WehealthyLogic();
  bool isMen = false;
  bool textfieldRead = true;
  bool visibilityUpdateBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectUserData();
  }

  void selectUserData() async {
    await Future.delayed(Duration(seconds: 3));
    final User? user = auth.currentUser;
    _currentUser = user!;
    List tempData = [];

    tempData = jsonDecode(await ds.selectWhere(
        token, project, "user_data", appid, 'user_id', userId));
    _dataUser = tempData.map((e) => UserDataModel.fromJson(e)).toList();

    setState(() {
      if (_dataUser[0].gender == 'Pria') {
        isMen = true;
      }
      gender = _dataUser[0].gender;
      umur.text = _dataUser[0].umur;
      berat_badan.text = _dataUser[0].berat_badan;
      tinggi_badan.text = _dataUser[0].tinggi_badan;
      bmi.text = _dataUser[0].bmi;
      kalori_perhari.text = _dataUser[0].kalori_perhari;
      kegiatan = double.parse(_dataUser[0].kegiatan);
      kategori_berat.text = _dataUser[0].kategori_berat;
      update_id = _dataUser[0].id;
      loading = false;
    });
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: isMen
                                  ? CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      child: Icon(Icons.person),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.pink,
                                      foregroundColor: Colors.white,
                                      child: Icon(Icons.person),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                    "${_currentUser.displayName}",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                    '${_currentUser.email}',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Visibility(
                                    visible: textfieldRead,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blueAccent,
                                          onPrimary: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          textfieldRead = false;
                                          visibilityUpdateBtn = true;
                                        });
                                      },
                                      child: Text(
                                        'Update Data',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(right: 0, left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Umur'),
                                  SizedBox(height: 5),
                                  TextField(
                                      controller: umur,
                                      readOnly: textfieldRead,
                                      onTap: () => showDialogPicker(context),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.left,
                                      decoration: kTextFieldDecoration),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Berat Badan'),
                          SizedBox(height: 5),
                          TextField(
                              controller: berat_badan,
                              readOnly: textfieldRead,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              decoration:
                                  const InputDecoration(hintText: 'Kilogram')),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tinggi Badan'),
                          SizedBox(height: 5),
                          TextField(
                              controller: tinggi_badan,
                              readOnly: textfieldRead,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              decoration:
                                  InputDecoration(hintText: 'Centimeter')),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kegiatan Sehari-hari'),
                          SizedBox(height: 5),
                          DropdownButtonFormField(
                            decoration: kTextFieldDecoration,
                            value: kegiatan,
                            items: const [
                              DropdownMenuItem(
                                value: 1.2,
                                child: Text(
                                  'Melakukan Aktifitas Ringan',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1.375,
                                child: Text(
                                  'Melakukan Pekerjaan ringan',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1.55,
                                child: Text(
                                  'Bekerja dan Berolahraga pasif',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1.725,
                                child: Text(
                                  'Sering berolahraga dan bekerja',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1.9,
                                child: Text(
                                  'Bekerja keras atau Seorang atlit',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                            onChanged: (newValue) {
                              setState(() {
                                kegiatan = newValue!;
                              });
                            },
                          )
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: _loading
                          ? const CircularProgressIndicator()
                          : Visibility(
                              visible: visibilityUpdateBtn,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueAccent,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _loading = true;
                                  });
                                  String bb = berat_badan.text;
                                  String um = umur.text;
                                  String tb = tinggi_badan.text;

                                  bool updateStatus = await whl.updateUserData(
                                      userId,
                                      double.parse(bb),
                                      kegiatan,
                                      int.parse(um),
                                      double.parse(tb));

                                  if (updateStatus) {
                                    Navigator.pushNamed(context, 'profile_page',
                                        arguments: {
                                          'userId': userId,
                                        });
                                  }
                                },
                                child: const Text('Update',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: bottomNavigationBar(userId: userId),
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

        umur.text = '${umurPicker.toString()} Tahun';
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
