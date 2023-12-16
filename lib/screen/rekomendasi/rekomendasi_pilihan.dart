import 'package:flutter/material.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class RekomendasiPilihan extends StatefulWidget {
  const RekomendasiPilihan({Key? key});

  @override
  State<RekomendasiPilihan> createState() => _RekomendasiPilihanState();
}

class _RekomendasiPilihanState extends State<RekomendasiPilihan> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi');
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
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 80),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'rekomendasi_hari_makanan',
                        arguments: {
                          'periodisasi': '',
                          'userID': '',
                          'pilihan': 'makanan'
                        });
                  },
                  child: Card(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Image.asset(
                          'olahraga.png',
                          width: double.infinity,
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
                    Navigator.pushNamed(context, 'rekomendasi_hari_makanan',
                        arguments: {
                          'periodisasi': '',
                          'userID': '',
                          'pilihan': 'makanan'
                        });
                  },
                  child: Card(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Image.asset(
                          'makanan.png',
                          width: double.infinity,
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
