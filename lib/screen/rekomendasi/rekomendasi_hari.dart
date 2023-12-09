import 'package:flutter/material.dart';

class rekomendasiHari extends StatefulWidget {
  const rekomendasiHari({Key? key});

  @override
  State<rekomendasiHari> createState() => _rekomendasiHariState();
}

class _rekomendasiHariState extends State<rekomendasiHari> {
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
                      width: 380,
                      fit: BoxFit.fill,
                    ),
                    ListTile(
                      title: Text(
                        'Tips & Trick',
                        style: TextStyle(fontSize: 26, color: Colors.orange),
                      ),
                      subtitle: Text(
                        'Makanlah makanan sehat dengan variasi nutrisi dan atur workout secara teratur untuk mencapai keseimbangan tubuh yang optimal.',
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                    ),
                  ],
                ),
              );
            }

            final item = hari[index - 1];

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              child: ListTile(
                leading: Icon(Icons.fitness_center),
                title: Text(item),
              ),
            );
          },
        ),
      ),
    );
  }
}
