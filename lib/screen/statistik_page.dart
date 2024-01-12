import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:we_healthy/models/makanan_day_model.dart';
import 'package:we_healthy/models/user_model.dart';
import 'package:we_healthy/models/user_week_model.dart';
import 'package:we_healthy/models/workout_day_model.dart';
import 'package:we_healthy/services/etter_services.dart';
import 'package:we_healthy/utils/bottom_bar.dart';
import 'package:we_healthy/utils/config.dart';

DataService ds = DataService();

class StatistikPage extends StatefulWidget {
  const StatistikPage({Key? key}) : super(key: key);

  @override
  _StatistikPageState createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  List<String> hari = ['1', '2', '3', '4', '5', '6', '7'];
  List<int> points = List.filled(7, 0);
  String uid = '';
  bool loading = true;
  double bmi = 0;
  String classification = "loading...";

  void getDataProgress() async {
    await Future.delayed(Duration(seconds: 3));
    List tempData = [];
    List<UserDataModel> _dataUser = [];

    tempData = jsonDecode(await ds.selectWhere(
        token, project, "user_data", appid, 'user_id', uid));
    _dataUser = tempData.map((e) => UserDataModel.fromJson(e)).toList();

    bmi = double.parse(_dataUser[0].bmi);
    classification = _dataUser[0].kategori_berat;

    List<MakananDayModel> makananDataEtter = [];
    List<WorkoutDayModel> workoutDataEtter = [];
    List<int> makananPts = List.filled(7, 0);
    List<int> workoutPts = List.filled(7, 0);

    List tempMakananData = jsonDecode(await ds.selectWhere(
        token, project, 'makanan_day', appid, 'user_id', uid));
    List tempWorkoutData = jsonDecode(await ds.selectWhere(
        token, project, 'workout_day', appid, 'user_id', uid));

    makananDataEtter =
        tempMakananData.map((e) => MakananDayModel.fromJson(e)).toList();
    workoutDataEtter =
        tempWorkoutData.map((e) => WorkoutDayModel.fromJson(e)).toList();

    List<String> makananSelesai =
        makananDataEtter.map((item) => item.hari).toList();
    List<String> workoutSelesai =
        workoutDataEtter.map((item) => item.hari).toList();

    makananPts = List.generate(
      hari.length,
      (index) => makananSelesai.contains(hari[index]) ? 1 : 0,
    );

    workoutPts = List.generate(
      hari.length,
      (index) => workoutSelesai.contains(hari[index]) ? 1 : 0,
    );

    for (var i = 0; i < points.length; i++) {
      setState(() {
        points[i] = makananPts[i] + workoutPts[i];
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataProgress();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      uid = args['userId'];
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset('assets/logo/logo_blue.png'),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          'assets/progress.png',
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 200,
                        ),
                      ),
                      SizedBox(height: 25),
                      Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Column(
                              children: [
                                Text('Progress Program',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 20),
                                    DayColumn(
                                        day: 'Hari 1',
                                        iconProg: '${points[0]}'),
                                    SizedBox(width: 10),
                                    DayColumn(
                                        day: 'Hari 2',
                                        iconProg: '${points[1]}'),
                                    SizedBox(width: 10),
                                    DayColumn(
                                        day: 'Hari 3',
                                        iconProg: '${points[2]}'),
                                    SizedBox(width: 10),
                                    DayColumn(
                                        day: 'Hari 4',
                                        iconProg: '${points[3]}'),
                                    SizedBox(width: 10),
                                    DayColumn(
                                        day: 'Hari 5',
                                        iconProg: '${points[4]}'),
                                    SizedBox(width: 10),
                                    DayColumn(
                                        day: 'Hari 6',
                                        iconProg: '${points[5]}'),
                                    SizedBox(width: 10),
                                    DayColumn(
                                        day: 'Hari 7',
                                        iconProg: '${points[6]}'),
                                    SizedBox(width: 20),
                                  ],
                                ),
                                SizedBox(height: 30),
                                ProgressType(),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      BmiDetails(bmi: bmi, classification: classification),
                      SizedBox(height: 25),
                      ChartCard(userId: uid),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: bottomNavigationBar(userId: uid),
    );
  }
}

class BmiDetails extends StatelessWidget {
  final double bmi;
  final String classification;

  const BmiDetails({Key? key, required this.bmi, required this.classification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    child: Text(
                      "$bmi",
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
                      classification,
                      style: TextStyle(
                        fontSize: 15.0,
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
          SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Klasifikasi Skor BMI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          '18.5 kebawah',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '18.6 - 24.9',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '25 - 29.9',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '30 - 34.9',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '35 - 39.9',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '40 Keatas',
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
                          'Kurus',
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
                          'Kelebihan berat',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 231, 214, 59)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Obesitas 1',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Obesitas 2',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Obesitas 3',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 109, 0, 0)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DayColumn extends StatelessWidget {
  final String day;
  final String iconProg;

  const DayColumn({Key? key, required this.day, required this.iconProg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(fontSize: 11),
        ),
        SizedBox(height: 10),
        CircleAvatar(
          radius: 13, // Image radius
          backgroundImage: AssetImage('assets/icon/$iconProg.png'),
        ),
      ],
    );
  }
}

class ChartCard extends StatefulWidget {
  final String userId;
  const ChartCard({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  double averageWeight = 0;
  double beforeWeight = 0;
  double currentWeight = 0;
  List<double> berat = [];
  bool _loadingChart = true;
  bool _chartVisibility = false;

  Future getWeightWeek() async {
    await Future.delayed(const Duration(seconds: 3));
    List<UserWeekModel> getWeight = [];
    List tempGetWeight = jsonDecode(await ds.selectWhere(
        token, project, 'user_week', appid, 'user_id', widget.userId));

    getWeight = tempGetWeight.map((e) => UserWeekModel.fromJson(e)).toList();
    berat = getWeight.map((UserWeekModel model) {
      return double.parse(model.berat_badan);
    }).toList();

    if (getWeight.length != 1) {
      for (double beratPerWeek in berat) {
        averageWeight += beratPerWeek;
      }

      int maxProgressWeight = berat.length - 1;

      averageWeight = (averageWeight / (maxProgressWeight + 1)).roundToDouble();
      beforeWeight = (berat[maxProgressWeight - 1]).roundToDouble();
      currentWeight = (berat[maxProgressWeight]).roundToDouble();

      setState(() {
        _loadingChart = false;
        _chartVisibility = true;
      });
    } else {
      setState(() {
        _loadingChart = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeightWeek();
  }

  @override
  Widget build(BuildContext context) {
    return _loadingChart
        ? const CircularProgressIndicator()
        : _chartVisibility
            ? Card(
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Statistik Kalori',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Sebelumnya',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '$beforeWeight',
                                  style: TextStyle(fontSize: 26),
                                ),
                                Text(
                                  'Kilogram',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Column(
                              children: [
                                Text(
                                  'Saat Ini',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '$currentWeight',
                                  style: TextStyle(fontSize: 26),
                                ),
                                Text(
                                  'Kilogram',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Column(
                              children: [
                                Text(
                                  'Rata rata',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  '$averageWeight',
                                  style: TextStyle(fontSize: 26),
                                ),
                                Text(
                                  'Kilogram',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  right: 18, top: 24, bottom: 12),
                              child: LineChart(
                                LineChartData(
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(
                                        berat.length,
                                        (index) => FlSpot(
                                            index.toDouble(), berat[index]),
                                      ),
                                      isCurved: true,
                                      color: Colors.blue,
                                      isStrokeCapRound: true,
                                      dotData: const FlDotData(
                                        show: false,
                                      ),
                                    ),
                                  ],
                                  titlesData: const FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        reservedSize: 30,
                                        getTitlesWidget: bottomTitleWidget,
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      axisNameWidget: Text('Berat Badan kg'),
                                      axisNameSize: 21,
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 3,
                                        reservedSize: 33,
                                        getTitlesWidget: leftTitleWidget,
                                      ),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Text(
                'Diagram akan tampil diminggu ke dua',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
  }
}

class ProgressType extends StatelessWidget {
  const ProgressType({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconProgress(
              iconName: '0',
              desc: 'Tidak menyelesaikan Rekomandasi makanan dan olahraga'),
          SizedBox(height: 5),
          IconProgress(
              iconName: '1',
              desc: 'Hanya menyelesaikan Rekomendasi makanan atau olahraga'),
          SizedBox(height: 5),
          IconProgress(iconName: '2', desc: 'Menyelesaikan keduanya'),
        ],
      ),
    );
  }
}

class IconProgress extends StatelessWidget {
  final String iconName;
  final String desc;

  const IconProgress({Key? key, required this.iconName, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12, // Image radius
          backgroundImage: AssetImage('assets/icon/$iconName.png'),
        ),
        SizedBox(width: 5),
        Text(
          ' : $desc',
          style: TextStyle(fontSize: 9),
        )
      ],
    );
  }
}

Widget bottomTitleWidget(double value, TitleMeta meta) {
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      'Minggu ${value.toInt() + 1}',
    ),
  );
}

Widget leftTitleWidget(double value, TitleMeta meta) {
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      '${value.toInt() + 1}',
    ),
  );
}
