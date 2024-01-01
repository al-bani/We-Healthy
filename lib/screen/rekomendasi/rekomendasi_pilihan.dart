import 'package:flutter/material.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class RekomendasiPilihan extends StatefulWidget {
  const RekomendasiPilihan({super.key});

  @override
  State<RekomendasiPilihan> createState() => _RekomendasiPilihanState();
}

class _RekomendasiPilihanState extends State<RekomendasiPilihan> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi',
                  arguments: {'userId': args['userId']});
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
        title: Image.asset(
          'assets/wehealty.png',
          fit: BoxFit.contain,
          height: 170,
        ),
      ),
      backgroundColor: Color(0xFFE6E7EB),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 80),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'rekomendasi_hari_olahraga',
                          arguments: {
                            'periodisasi': args['periodisasi'],
                            'userId': args['userId'],
                            'pilihan': 'olahraga'
                          });
                    },
                    child: Card(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Image.asset(
                            'assets/olahraga.png',
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
                      Navigator.pushNamed(context, 'rekomendasi_hari_makan',
                          arguments: {
                            'periodisasi': args['periodisasi'],
                            'userId': args['userId'],
                            'pilihan': 'makanan'
                          });
                    },
                    child: Card(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Image.asset(
                            'assets/makanan.png',
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
            ),
          )),
      bottomNavigationBar: bottomNavigationBar(userId: args['userId']),
    );
  }
}
