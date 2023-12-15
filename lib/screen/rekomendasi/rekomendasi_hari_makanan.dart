import 'package:flutter/material.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class RekomendasiHariMakanan extends StatefulWidget {
  const RekomendasiHariMakanan({Key? key});

  @override
  State<RekomendasiHariMakanan> createState() => _RekomendasiHariMakananState();
}

class _RekomendasiHariMakananState extends State<RekomendasiHariMakanan> {
  List<String> hari = [
    'Hari 1',
    'Hari 2',
    'Hari 3',
    'Hari 4',
    'Hari 5',
    'Hari 6',
    'Hari 7'
  ]; // Perhatikan bahwa hari sebaiknya memiliki tipe data List<String>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'rekomendasi_pilihan');
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
                onTap: () {
                  Navigator.pushNamed(context, 'rekomendasi_makanan');
                },
                leading: Icon(Icons.fitness_center),
                title: Text(
                  item,
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
