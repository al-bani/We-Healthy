import 'package:flutter/material.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class Rekomendasi extends StatefulWidget {
  const Rekomendasi({super.key});

  @override
  State<Rekomendasi> createState() => _RekomendasiState();
}

class _RekomendasiState extends State<Rekomendasi> {
  List<String> periodisasi = ['Bulking', 'Maintance', 'Cutting'];
  String userId = ' ';

  List<String> deskripsi = [
    'Meningkatkan kalori untuk membangun otot. blablablalba',
    'Menjaga keseimbangan kalori untuk mempertahankan berat badan.',
    'Mengurangi kalori untuk menurunkan lemak tubuh.'
  ];

  List<String> gambar = [
    'rekomendasi/bulking.png',
    'rekomendasi/maintance.png',
    'rekomendasi/cutting.png'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      userId = args['userId'];
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'home_screen', arguments: {
                'userId': userId,
              });
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
          itemCount:
              periodisasi.length + 1, // Menambahkan 1 untuk Card Tips & Trick
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      'gym.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    ListTile(
                      title: new Center(
                        child: Text(
                          "Pilih Tipe Anda !",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(10.0, 10.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(10.0, 10.0),
                                blurRadius: 8.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final item = periodisasi[index - 1];
            final desk = deskripsi[index - 1];
            final img = gambar[index - 1];

            return Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                onTap: () {
                  Navigator.pushNamed(context, 'rekomendasi_pilihan',
                      arguments: {'periodisasi': item, 'userId': userId});
                },
                leading: Image.asset(
                  '$img',
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
      bottomNavigationBar: bottomNavigationBar(userId: userId),
    );
  }
}
