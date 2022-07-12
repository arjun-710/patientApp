import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/screens/Doctor/docLanding.dart';
import 'package:patient_app/screens/Doctor/docLogin.dart';
import 'package:patient_app/screens/Doctor/docRegister.dart';
import 'package:patient_app/screens/LoginScreen.dart';
import 'package:patient_app/screens/Patient/patLogin.dart';
import 'package:patient_app/screens/Patient/patRegister.dart';
import 'package:patient_app/screens/landingPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient App',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingPage(),
        '/patLogin': (context) => const PatLogin(),
        '/docLogin': (context) => const DocLogin(),
        '/DocLanding': (context) => const DocLanding(),
        '/docRegister': (context) => const docRegister(),
        '/patRegister': (context) => const PatRegister(),

      },
    );
  }
}
