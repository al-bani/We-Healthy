import 'package:flutter/material.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_makanan.dart';
import 'package:we_healthy/screen/rekomendasi/rekomendasi_olahraga.dart';
import 'package:we_healthy/utils/app_bar.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class rekomendasiPilihan extends StatefulWidget {
  const rekomendasiPilihan({Key? key});

  @override
  State<rekomendasiPilihan> createState() => _rekomendasiPilihanState();
}

class _rekomendasiPilihanState extends State<rekomendasiPilihan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Color(0xFFE6E7EB),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 80),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => rekomendasiOlahraga(),
                      ),
                    );
                  },
                  child: Card(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Image.asset(
                          'olahraga.png',
                          width: 380,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          '  Olahraga',
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => rekomendasiMakanan(),
                      ),
                    );
                  },
                  child: Card(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Image.asset(
                          'makanan.png',
                          width: 380,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'Makanan',
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
