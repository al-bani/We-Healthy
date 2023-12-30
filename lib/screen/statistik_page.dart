import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:we_healthy/models/makanan_day_model.dart';
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

  void getDataProgress() async {
    await Future.delayed(Duration(seconds: 3));
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
        automaticallyImplyLeading: false,
        title: Image.asset(
          'wehealty.png',
          fit: BoxFit.contain,
          height: 170,
        ),
      ),
      backgroundColor: Color.fromRGBO(230, 231, 235, 100),
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
                          'progress.png',
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
                      ChartCard(),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: bottomNavigationBar(userId: uid),
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
          backgroundImage: AssetImage('/icon/$iconProg.png'),
        ),
      ],
    );
  }
}

class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

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
    List tempGetWeight = jsonDecode(await ds.selectWhere(token, project,
        'user_week', appid, 'user_id', '59w6w4ZOUCeUfVh6HQ0yl5pnm6Q2'));

    getWeight = tempGetWeight.map((e) => UserWeekModel.fromJson(e)).toList();
    berat = getWeight.map((UserWeekModel model) {
      return double.parse(model.berat_badan);
    }).toList();

    if (getWeight.length != 1) {
      for (double angka in berat) {
        averageWeight += angka;
      }

      int maxProgressWeight = berat.length - 1;

      averageWeight = (averageWeight / maxProgressWeight + 1).roundToDouble();
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
                        AspectRatio(
                          aspectRatio: 2.2,
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
          backgroundImage: AssetImage('icon/$iconName.png'),
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
      'Week ${value.toInt() + 1}',
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
