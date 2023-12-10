import 'package:flutter/material.dart';

class rekomendasiMakanan extends StatefulWidget {
  const rekomendasiMakanan({Key? key});

  @override
  State<rekomendasiMakanan> createState() => _rekomendasiMakananState();
}

class _rekomendasiMakananState extends State<rekomendasiMakanan> {
  List<String> gambar = [
    '/rekomendasi/makanan/nasi.png',
    '/rekomendasi/makanan/Ayam.png',
    '/rekomendasi/makanan/pisang.png',
  ];

  List<String> nama = [
    'Nasi',
    'Dada Ayam',
    'Pisang'
  ]; // Perhatikan bahwa hari sebaiknya memiliki tipe data List<String>

  List<String> sajian = ['100g', '1 Potong', '1 Buah'];

  List<int> kalori = [200, 100, 50];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'makanan.png',
                      width: 380,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8), // Adjust padding as needed
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
                itemCount: nama.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                    child: ListTile(
                      leading: Image.asset('${gambar[index]}'),
                      title: Text('${nama[index]}'),
                      subtitle: Text('Sajian: ${sajian[index]}'),
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
    );
  }
}
