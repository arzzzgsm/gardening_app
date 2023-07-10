import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'syngonium_log.dart';

class SyngoniumPage extends StatefulWidget {
  @override
  _SyngoniumPageState createState() => _SyngoniumPageState();
}

class _SyngoniumPageState extends State<SyngoniumPage> {
  final DatabaseReference _sensorDataRef =
      FirebaseDatabase.instance.reference().child('sensor_data');
  final DatabaseReference _pompa1Ref =
      FirebaseDatabase.instance.reference().child('sensor_data').child('pompa_1');
  final DatabaseReference _pompa2Ref =
      FirebaseDatabase.instance.reference().child('sensor_data').child('pompa_2');

  @override
  void initState() {
    super.initState();
    _sensorDataRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        var sensorData = event.snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          _soilMoisture = (sensorData['soil_moisture'] ?? 0).toString();
          _phValue = (sensorData['ph_value'] ?? 0).toString();
          _temperature = (sensorData['temperature'] ?? 0).toString();
        });
      }
    });

    _pompa1Ref.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _pompa1Status = event.snapshot.value.toString();
        });
      }
    });

    _pompa2Ref.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _pompa2Status = event.snapshot.value.toString();
        });
      }
    });
  }

  String _soilMoisture = '';
  String _phValue = '';
  String _temperature = '';
  String _pompa1Status = '';
  String _pompa2Status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(38, 0, 32, 35),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 20), // Adjust margin to move up slightly
              width: double.infinity,
              height: 38,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 100, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xbf5a8c5c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 7, 15, 8),
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 2, 9, 0),
                              width: 5,
                              height: 11,
                              child: Image.asset(
                                'assets/images/vector_back.png',
                                width: 5,
                                height: 11,
                              ),
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(60, 0, 10, 0),
                    height: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SyngoniumLog(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xbf5a8c5c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 7, 15, 8),
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 3, 10, 0),
                              width: 5,
                              height: 11,
                              child: Image.asset(
                                'assets/images/vector_log.png',
                                width: 5,
                                height: 11,
                              ),
                            ),
                            Text(
                              'Log',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(7, 20, 14, 20), // Adjust margin to move up slightly
              child: Text(
                'Syngonium',
                style: TextStyle(
                  fontFamily: 'Overlock',
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  height: 1.22,
                  color: Color(0xff346336),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(6, 0, 14, 15),
              width: 157,
              height: 157,
              child: Image.asset(
                'assets/images/syngonium.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(6, 30, 0, 43),
              width: double.infinity,
              height: 107,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    padding: EdgeInsets.fromLTRB(18, 15, 0, 0),
                    width: 210,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffb4e4c1),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            'Kelembapan Tanah : $_soilMoisture %',
                            style: TextStyle(
                              fontFamily: 'Overlock',
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              height: 1.22,
                              color: Color(0xff1b2b1b),
                            ),
                          ),
                        ),
                        Text(
                          'PH tanah : $_phValue',
                          style: TextStyle(
                            fontFamily: 'Overlock',
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            height: 1.22,
                            color: Color(0xff1b2b1b),
                          ),
                                                  ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(18, 20, 18, 20),
                    width: 97,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffb4e5c2),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Text(
                      'Suhu : $_temperature °C',
                      style: TextStyle(
                        fontFamily: 'Overlock',
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        height: 1.22,
                        color: Color(0xff1b2b1b),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 230, 9),
              child: Text(
                'Status Pompa',
                style: TextStyle(
                  fontFamily: 'Overlock',
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  height: 1.22,
                  color: Color(0xff1b2c1c),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 150, 0),
              padding: EdgeInsets.fromLTRB(18, 20, 18, 29),
              width: 188,
              decoration: BoxDecoration(
                color: Color(0xffb4e4c1),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      'Pompa 1 : $_pompa1Status',
                      style: TextStyle(
                        fontFamily: 'Overlock',
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        height: 1.22,
                        color: Color(0xff1b2b1b),
                      ),
                    ),
                  ),
                  Text(
                    'Pompa 2 : $_pompa2Status',
                    style: TextStyle(
                      fontFamily: 'Overlock',
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      height: 1.22,
                      color: Color(0xff1b2b1b),
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syngonium',
      home: SyngoniumPage(),
      routes: {
        '/logsyngonium': (context) => SyngoniumLog(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/logsyngonium') {
          return MaterialPageRoute(
            builder: (context) => SyngoniumLog(),
          );
        }
        return null;
      },
    );
  }
}
