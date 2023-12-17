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
                            'makanan.png',
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8), // Adjust padding as needed
                            child: Text(
                              'Makanan',
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
                      itemCount: carbsList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                          child: ListTile(
                            leading: Image.asset('${gambar[index]}'),
                            title: Text(carbsList[0].nama_makanan),
                            subtitle:
                                Text('Sajian: ${carbsList[0].jumlah_sajian}'),
                            trailing: Text(
                              '${carbsList[0].kalori} Kal',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: fatsList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                          child: ListTile(
                            leading: Image.asset('${gambar[index]}'),
                            title: Text(fatsList[0].nama_makanan),
                            subtitle:
                                Text('Sajian: ${fatsList[0].jumlah_sajian}'),
                            trailing: Text(
                              '${fatsList[0].kalori} Kal',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: proteinList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                          child: ListTile(
                            leading: Image.asset('${gambar[index]}'),
                            title: Text(proteinList[0].nama_makanan),
                            subtitle:
                                Text('Sajian: ${proteinList[0].jumlah_sajian}'),
                            trailing: Text(
                              '${proteinList[0].kalori} Kal',
                              style: TextStyle(fontSize: 14),
                            ),
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
