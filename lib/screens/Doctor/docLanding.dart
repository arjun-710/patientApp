import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/components/appBar.dart';

class DocLanding extends StatelessWidget {
  const DocLanding({Key? key}) : super(key: key);
  @override
  void initState(context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar().appBar(),
      body: SafeArea(
        child: ListView(
          children: const [
            Text('Doctor Landing'),
          ],
        ),
      ),
    );
  }
}
