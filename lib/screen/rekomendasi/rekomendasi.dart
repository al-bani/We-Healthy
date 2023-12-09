import 'package:flutter/material.dart';

class Rekomendasi extends StatefulWidget {
  const Rekomendasi({Key? key});

  @override
  State<Rekomendasi> createState() => _RekomendasiState();
}

class _RekomendasiState extends State<Rekomendasi> {
  List<String> hari = [
    'Bulking',
    'Maintance',
    'Cutting'
  ]; // Perhatikan bahwa hari sebaiknya memiliki tipe data List<String>

  List<String> deskripsi = [
    'Meningkatkan kalori untuk membangun otot. blablablalba',
    'Menjaga keseimbangan kalori untuk mempertahankan berat badan.',
    'Mengurangi kalori untuk menurunkan lemak tubuh.'
  ];

  List<String> gambar = ['bulking.png', 'maintance.png', 'cutting.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E7EB),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: hari.length + 1, // Menambahkan 1 untuk Card Tips & Trick
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
                child: Stack(
                  // mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    Image.asset(
                      'gym.png',
                      width: 380,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    ListTile(
                      title: Text(
                        'Tips & Trick',
                        style: TextStyle(
                            fontSize: 26, color: Colors.lightGreenAccent),
                      ),
                      subtitle: Text(
                        'Makanlah makanan sehat dengan variasi nutrisi dan atur workout secara teratur untuk mencapai keseimbangan tubuh yang optimal.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            final item = hari[index - 1];
            final desk = deskripsi[index - 1];
            final img = gambar[index - 1];

            return Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
              // color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/$img',
                  scale: 10,
                  fit: BoxFit.fitWidth,
                ),
                title: Text(
                  item,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(desk),
              ),
            );
          },
        ),
      ),
    );
  }
}
