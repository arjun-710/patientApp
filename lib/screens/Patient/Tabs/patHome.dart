import 'package:flutter/material.dart';

class PatHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        alignment: Alignment.center,
        height: 300,
        width: 300,
        color: Colors.cyan,
        child: Text(
          style: TextStyle(color: Colors.white, fontSize: 30),
          "PatHome",
        ),
      )),
    );
  }
}
