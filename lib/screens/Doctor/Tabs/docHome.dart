import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:provider/provider.dart';

class DocHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
        onTap: () {
          log("sign out");
          context.read<AuthService>().signOut(context);
        },
        child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          color: Colors.cyan,
          child: Text(
            style: TextStyle(color: Colors.white, fontSize: 30),
            "DocHome",
          ),
        ),
      )),
    );
  }
}
