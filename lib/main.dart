import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/screens/Doctor/docLanding.dart';
import 'package:patient_app/screens/Doctor/docLogin.dart';
import 'package:patient_app/screens/Doctor/docRegister.dart';
import 'package:patient_app/screens/Doctor/providers/docbottomNavigation.dart';
import 'package:patient_app/screens/Patient/patLogin.dart';
import 'package:patient_app/screens/Patient/patRegister.dart';
import 'package:patient_app/screens/Patient/providers/bottomNavigation.dart';
import 'package:patient_app/screens/landingPage.dart';
import 'package:patient_app/screens/Patient/patLanding.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ListenableProvider<AuthService>(
        create: (_) => AuthService(FirebaseAuth.instance),
      ),
      StreamProvider(
        create: (context) => context.read<AuthService>().authState,
        initialData: null,
      ),
      ChangeNotifierProvider(
          create: (_) =>
              PatBottomNavigation()), // add your providers like this.
      ChangeNotifierProvider(
          create: (_) =>
              DocBottomNavigation()), // add your providers like this.
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingPage(),
        '/patLogin': (context) => const PatLogin(),
        '/docLogin': (context) => const DocLogin(),
        '/DocLanding': (context) => DocLanding(),
        '/PatLanding': (context) => PatLanding(),
        '/docRegister': (context) => const DocRegister(),
        '/patRegister': (context) => const PatRegister(),
      },
    );
  }
}

// class Wrapper extends StatelessWidget {
//   const Wrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//     return StreamBuilder<User?>(
//         stream: authService.authState,
//         builder: (_, AsyncSnapshot<User?> snapshot) {
//           log(snapshot.connectionState.name);
//           if (snapshot.connectionState == ConnectionState.active) {
//             final User? user = snapshot.data;

//             return user == null ? const PatLogin() : const LandingPage();
//           } else {
//             return const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         });
//   }
// }
