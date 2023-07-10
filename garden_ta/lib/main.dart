import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'aglonema_page.dart';
import 'syngonium_page.dart';
import 'cathalea_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "gardening-flutter.firebaseapp.com",
      authDomain: "gardening-flutter.firebaseapp.com",
      databaseURL: "https://gardening-flutter-default-rtdb.asia-southeast1.firebasedatabase.app/",
      projectId: "gardening-flutter",
      storageBucket: "gardening-flutter.appspot.com",
      messagingSenderId: "gardening-flutter.appspot.com",
      appId: "1:469509834193:web:9ce2bdb856d2b163a5ccf0",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: null, // Menghapus konfigurasi warna
      ),
      routes: {
        '/aglonema': (context) => AglonemaPage(),
        '/syngonium': (context) => SyngoniumPage(),
        '/cathalea': (context) => CathaleaPage(),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  void saveDataToFirebase(String selectedPlant) {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.reference().child('selectedPlant');
    databaseRef.set(selectedPlant).then((value) {
      print('Data saved to Firebase Realtime Database');
    }).catchError((error) {
      print('Error saving data to Firebase Realtime Database: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(21),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 31.32),
                padding: EdgeInsets.fromLTRB(31, 60, 28, 0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF5FA86B),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(84),
                    bottomLeft: Radius.circular(84),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      offset: Offset(0, 5),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        'SELAMAT DATANG DI GARDENING APP',
                        style: TextStyle(
                          fontFamily: 'Overlock',
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          height: 1.22,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      width: 85,
                      height: 132.68,
                      child: Image.asset(
                        'assets/images/flower1.png',
                        width: 85,
                        height: 132.68,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF5FA86B), // Warna hijau pada box ComboBox
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: 'Aglonema',
                  dropdownColor: Color(0xFF5FA86B), // Warna hijau pada ComboBox
                  items: <String>[
                    'Aglonema',
                    'Syngonium',
                    'Cathalea',
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          item,
                          style: TextStyle(
                            color: Color(0xFFEDF1EE),
                            fontWeight: FontWeight.w700, // Warna teks pada ComboBox
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    saveDataToFirebase(newValue!);
                    switch (newValue) {
                      case 'Aglonema':
                        Navigator.pushNamed(context, '/aglonema');
                        break;
                      case 'Syngonium':
                        Navigator.pushNamed(context, '/syngonium');
                        break;
                      case 'Cathalea':
                        Navigator.pushNamed(context, '/cathalea');
                        break;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 17),
                child: Text(
                  '* Guide',
                  style: TextStyle(
                    fontFamily: 'Overlock',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.22,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                width: 350.58,
                height: 363,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Color(0xFFC9F4D0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 17,
                      top: 19,
                      child: Container(
                        width: 325,
                        height: 157,
                        child: Text(
                          'Tes',
                          style: TextStyle(
                            fontFamily: 'Overlock',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.22,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
