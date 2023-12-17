import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:we_healthy/models/nutriens_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/services/wehealthy_services.dart';
import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';

class RekomendasiHariMakanan extends StatefulWidget {
  const RekomendasiHariMakanan({super.key});

  @override
  State<RekomendasiHariMakanan> createState() => _RekomendasiHariMakananState();
}

class _RekomendasiHariMakananState extends State<RekomendasiHariMakanan> {
  List<String> hari = ['1', '2', '3', '4', '5', '6', '7'];
  WehealthyLogic whl = WehealthyLogic();
  DataService ds = DataService();

  Future<int> statusInsertedFood(
      String userId, String day, String periodisasi) async {
    
    int status = await whl.insertFood(userId, day, periodisasi);

    if (status == 1) {
      return 1;
    }

    return 0;
  }

  Future<int> checkingFoodUser(String userId, String item) async {
    List tempUserFood = [];
    List<NutriensModel> tempCheckingFoodUser = [];

    tempUserFood = jsonDecode(await ds.selectWhere(
        token, project, 'carbs', appid, 'user_id', userId));
    tempCheckingFoodUser =
        tempUserFood.map((e) => NutriensModel.fromJson(e)).toList();

    if (tempCheckingFoodUser[0].hari == item) {
      return 1;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi_pilihan', arguments: {
                'periodisasi': args['periodisasi'],
                'userId': args['userId'],
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
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: hari.length + 1, // Menambahkan 1 untuk Card Tips & Trick
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 30),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      'fotohari.png',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              );
            }

            final item = hari[index - 1];

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(40, 20, 10, 20),
                onTap: () async {
                  int statusChecking =
                      await checkingFoodUser(args['userId'], item);

                  if (statusChecking == 1) {
                    Navigator.pushNamed(context, 'rekomendasi_makanan',
                        arguments: {
                          'periodisasi': args['periodisasi'],
                          'userId': args['userId'],
                          'pilihan': 'makanan',
                          'hari': item
                        });
                  } else {
                    int statusInserted = await statusInsertedFood(
                        args['userId'], item, args['periodisasi']);
                    print("status inserted $statusInserted");

                    if (statusInserted == 1) {
                      Navigator.pushNamed(context, 'rekomendasi_makanan',
                          arguments: {
                            'periodisasi': args['periodisasi'],
                            'userId': args['userId'],
                            'pilihan': 'makanan',
                            'hari': item
                          });
                    }
                  }
                },
                leading: Icon(Icons.fitness_center),
                title: Text(
                  "hari $item",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
