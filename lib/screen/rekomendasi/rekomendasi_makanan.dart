import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:we_healthy/models/nutriens_model.dart';
import 'package:we_healthy/services/etter_services.dart';
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
  List<NutriensModel> carbsList = [];
  List<NutriensModel> proteinList = [];
  List<NutriensModel> fatsList = [];

  DataService ds = DataService();
  List<String> gambar = [
    '/rekomendasi/makanan/nasi.png',
    '/rekomendasi/makanan/Ayam.png',
    '/rekomendasi/makanan/pisang.png',
  ];

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
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectFoodData();
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

    return loading
        ? const CircularProgressIndicator()
        : Scaffold(
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
                'wehealty.png',
                fit: BoxFit.contain,
                height: 170,
              ),
            ),
            backgroundColor: Color(0xFFE6E7EB),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'makanan.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                            height: 200,
                          ),
                        ),
                        Text(
                          "Total Kalori Anda 1288 kcal",
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
                        title: Text('Karbohidrat: 30%'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
                            child: ListTile(
                              title: Text(
                                  '${carbsList[0].nama_makanan}: ${carbsList[0].jumlah_sajian}g'),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage('icon.png'),
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
                                backgroundImage: AssetImage('icon.png'),
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
                        title: Text('Lemak: 30%'),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
                            child: ListTile(
                              title: Text(
                                  '${fatsList[0].nama_makanan}: ${fatsList[0].jumlah_sajian}g'),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage('icon.png'),
                              ),
                              subtitle: Text('${fatsList[0].kalori} kcal'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(),
          );
  }
}
