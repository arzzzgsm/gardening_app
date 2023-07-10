import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:garden_ta/aglonema_report.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aglonema',
      home: AglonemaLog(),
      routes: {
        '/reportaglonema': (context) => AglonemaReport(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/reportaglonema') {
          return MaterialPageRoute(
            builder: (context) => AglonemaReport(),
          );
        }
        return null;
      },
    );
  }
}

class AglonemaLog extends StatefulWidget {
  const AglonemaLog({Key? key}) : super(key: key);

  @override
  _AglonemaLogState createState() => _AglonemaLogState();
}

class _AglonemaLogState extends State<AglonemaLog> {
  List<MapEntry<dynamic, dynamic>> logList = [];

  @override
  void initState() {
    super.initState();
    fetchLogData();
  }

  void fetchLogData() {
    DatabaseReference logRef = FirebaseDatabase.instance.reference().child('log_data/Aglonema');
    logRef.get().then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        Map<dynamic, dynamic>? logData = snapshot.value as Map<dynamic, dynamic>?;
        if (logData != null) {
          setState(() {
            logList = logData.entries.toList();
          });
        }
      }
    }, onError: (error) {
      print('Error fetching log data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'LOG',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AglonemaReport()),
                        );
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
                            'Report',
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
                    left: 16,
                    top: 40,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Aksi yang akan dilakukan saat tombol "Back" ditekan
                        // Misalnya, navigasi ke halaman sebelumnya
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(width: 4),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                color: Color(0xff315a37),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 252,
                    right: 16,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: ListView.builder(
                        itemCount: logList.length,
                        itemBuilder: (context, index) {
                          var logEntry = logList[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Timestamp: ${logEntry.value['timestamp']}'),
                                  SizedBox(height: 8),
                                  Text('pH Value: ${logEntry.value['ph_value']}'),
                                  SizedBox(height: 8),
                                  Text('Pompa 1: ${logEntry.value['pompa_1']}'),
                                  SizedBox(height: 8),
                                  Text('Pompa 2: ${logEntry.value['pompa_2']}'),
                                  SizedBox(height: 8),
                                  Text('Soil Moisture: ${logEntry.value['soil_moisture']}'),
                                  SizedBox(height: 8),
                                  Text('Temperature: ${logEntry.value['temperature']}'),
                                ],
                              ),
                            ),
                          );
                        },
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
