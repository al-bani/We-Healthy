import 'package:flutter/material.dart';

class rekomendasiPilihan extends StatefulWidget {
  const rekomendasiPilihan({Key? key});

  @override
  State<rekomendasiPilihan> createState() => _rekomendasiPilihanState();
}

class _rekomendasiPilihanState extends State<rekomendasiPilihan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E7EB),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
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
                  Card(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Image.asset(
                          'makanan.png',
                          width: 380,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          '  Makanan',
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
