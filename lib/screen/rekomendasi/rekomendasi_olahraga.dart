import 'package:flutter/material.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class RekomendasiOlahraga extends StatefulWidget {
  const RekomendasiOlahraga({Key? key});

  @override
  State<RekomendasiOlahraga> createState() => _RekomendasiOlahragaState();
}

class _RekomendasiOlahragaState extends State<RekomendasiOlahraga> {
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi_hari_olahraga');
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Image.asset(
                      'Olahraga.png',
                      width: double.infinity,
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
