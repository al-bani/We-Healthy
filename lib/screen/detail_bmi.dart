import 'package:flutter/material.dart';
import 'package:we_healthy/utils/app_bar.dart';
import 'package:we_healthy/utils/bottom_bar.dart';

class bmiDetail extends StatefulWidget {
  const bmiDetail({super.key});

  @override
  State<bmiDetail> createState() => _bmiDetailState();
}

class _bmiDetailState extends State<bmiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
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
                ),
                const SizedBox(height: 15),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Klasifikasi Skor BMI',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '18 or less',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '25 - 29.99',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '25 - 29.99',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '30+',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                )),
                            
                            Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Underweight',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'normal',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Over Weight',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Obese',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'keterangan kalori',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sedentary',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Light Excercise',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Moderate Excercise',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Heavy Excercise',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Athlete',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                )),
                            
                            Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '1,770 calories per day',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '2,028 calories per day',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '2,286 calories per day',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '2,544 calories per day',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '2,803 calories per day',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                          ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: ListTile(
                            title: Text(
                              'Dampak dari Obesitas Kelas 1',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Obesitas kelas 1 ini merupakan kasmnciiahsnbubcan jna asnjabsjabsansn anskansnajn asnansjas asas as ajsnjansaj sajnsansjans ajsnjansja  ajsnajbdbjasbad  njsdnjnnsn sjdnjsnd '),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
