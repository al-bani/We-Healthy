import 'package:flutter/material.dart';
import 'package:we_healthy/utils/app_bar.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class rekomendasiOlahraga extends StatefulWidget {
  const rekomendasiOlahraga({Key? key});

  @override
  State<rekomendasiOlahraga> createState() => _rekomendasiOlahragaState();
}

class _rekomendasiOlahragaState extends State<rekomendasiOlahraga> {
  List<String> gambar = [
    '/rekomendasi/olahraga/pushup.png',
    '/rekomendasi/olahraga/situp.png',
    '/rekomendasi/olahraga/pullup.png',
  ];

  List<String> nama = [
    'Push Up',
    'SitUp',
    'Pull Up'
  ]; // Perhatikan bahwa hari sebaiknya memiliki tipe data List<String>

  List<String> repetisi = ['10', '15', '1000'];

  List<int> kalori = [200, 100, 50];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Color(0xFFE6E7EB),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Image.asset(
                      'Olahraga.png',
                      width: 380,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8), // Adjust padding as needed
                      child: Text(
                        'Olahraga',
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
                itemCount: nama.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                    child: ListTile(
                      leading: Image.asset('${gambar[index]}'),
                      title: Text('${nama[index]}'),
                      subtitle: Text('Repetisi: ${repetisi[index]}'),
                      trailing: Text(
                        '${kalori[index]} Kal',
                        style: TextStyle(fontSize: 14),
                      ),
                      // title: Text('Sajian: ${sajian[index]}'),
                      // subtitle: Text('Kalori: ${kalori[index]}'),
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
