// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Image.asset(
              '/logo/logo_blue.png' // Sesuaikan dengan tinggi yang diinginkan
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                              '/cuaca/sun.png'), // Ganti dengan path gambar Anda
                          fit: BoxFit
                              .cover, // Sesuaikan dengan preferensi desain Anda
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, top: 20.0),
                                      child: Text(
                                        'Ujung Berung',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        '27 ' + 'C',
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, bottom: 20.0),
                                      child: Text(
                                        'Kualitas Udara:' + ' Buruk',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.all(0),
                                child: const Icon(
                                  Icons.dangerous,
                                  size: 100,
                                  color: Colors.red,
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Card(
                  color: Color(0xFFfffffff),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                          "Dianjurkan Menggunakan Masker karena cuaca yang buruk dan Menggunakan Sunscreen untuk menjaga Kulit anda"),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Card(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Data Fisik:',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(
                                      '87',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Kilogram',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(
                                      '87',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Centimer',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: Text(
                              "12",
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFe0f2f1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: Text(
                              "12",
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFe0f2f1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "SKOR BMI",
                              style: TextStyle(
                                  fontSize: 17.0, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent
                                  ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                onPrimary: Colors.white
                              ),
                              onPressed: (){
                                 Navigator.pushNamed(context, 'detail_bmi');
                              }, 
                              child: Text(
                                'Detail'
                              )
                              )
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Card(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Kalori Pemeliharaan Anda:',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(
                                      '2.144',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Kalori per Hari',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(
                                      '15.600',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Kalori per Minggu',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.only(left: 130, right: 130)
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'rekomendasi');
                  }, 
                  child: Text(
                    'Lihat Rekomendasi'
                  )
                  )
              ],
            ),
          ),
        ),
      ),
       bottomNavigationBar: bottomNavigationBar(),
    );
  }
}

