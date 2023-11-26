import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: const ListTile(
                                title: Text('27 C'),
                                subtitle: Text('Ujung Berung'),
                              ),
                            ),
                            Expanded(
                              child: const ListTile(
                                title: Text('Kualitas Udara : Buruk'),
                                subtitle: Text(
                                    'Dianjurkan Menggunakan Masker karena cuaca yang buruk dan Menggunakan Sunscreen untuk menjaga Kulit anda'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Card(
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
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[],
                      ),
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
                          child: Text(
                            "Hasil BMI anda",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
