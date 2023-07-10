import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: CathaleaReport(),
    );
  }
}

class CathaleaReport extends StatefulWidget {
  @override
  _CathaleaReportState createState() => _CathaleaReportState();
}

class _CathaleaReportState extends State<CathaleaReport> {
  List<charts.Series<LogData, String>> seriesList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    DatabaseReference logRef = FirebaseDatabase.instance.reference().child('log_data/Cathalea');
    DataSnapshot snapshot = await logRef.once() as DataSnapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> logData = snapshot.value as Map<dynamic, dynamic>;
      List<LogData> data = [];

      logData.forEach((key, value) {
        data.add(LogData(value['timestamp'], value['temperature'], value['ph_value'], value['soil_moisture']));
      });

      setState(() {
        seriesList = [
          charts.Series<LogData, String>(
            id: 'Temperature',
            domainFn: (LogData log, _) => log.timestamp,
            measureFn: (LogData log, _) => log.temperature,
            data: data,
          ),
          charts.Series<LogData, String>(
            id: 'pH Value',
            domainFn: (LogData log, _) => log.timestamp,
            measureFn: (LogData log, _) => log.phValue,
            data: data,
          ),
          charts.Series<LogData, String>(
            id: 'Soil Moisture',
            domainFn: (LogData log, _) => log.timestamp,
            measureFn: (LogData log, _) => log.soilMoisture,
            data: data,
          ),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cathalea Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 844,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(21),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        width: 393,
                        height: 177,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff5fa86b),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(84),
                              bottomLeft: Radius.circular(84),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0, 5),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 169,
                    top: 88,
                    child: Align(
                      child: SizedBox(
                        width: 52,
                        height: 35,
                        child: Text(
                          'Report',
                          style: TextStyle(
                            fontFamily: 'Overlock',
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                            height: 1.22,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 295,
                    top: 40,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 62,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0, 4),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontFamily: 'Overlock',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.22,
                              color: Color(0xff315a37),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 32,
                    top: 200,
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: charts.BarChart(
                        seriesList,
                        animate: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogData {
  final String timestamp;
  final double temperature;
  final double phValue;
  final double soilMoisture;

  LogData(this.timestamp, this.temperature, this.phValue, this.soilMoisture);
}
