import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
    return ListView(
      children: [
        Container(
          child: Text(('Doctor Landing')),
        ),
      ],
    );
  }
}
