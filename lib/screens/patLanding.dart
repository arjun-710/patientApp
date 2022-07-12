import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:patient_app/components/appBar.dart';
import 'package:patient_app/components/patBottomBar.dart';

class PatLanding extends StatefulWidget {
  const PatLanding({Key? key}) : super(key: key);

  @override
  State<PatLanding> createState() => _PatLandingState();
}

class _PatLandingState extends State<PatLanding> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamed(context, '/patLogin');
      }
    });
    // auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(label: "Patient").appBar(),
      body: SafeArea(
        child: ListView(
          children: const [
            Text('Patient Landing'),
          ],
        ),
      ),
      bottomNavigationBar: PatBottomBar().patBottomBar(),
    );
  }
}
