import 'package:flutter/material.dart';
import 'package:patient_app/screens/Patient/components/AddRecord.dart';

class PatRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        alignment: Alignment.center,
        height: 300,
        width: 300,
        color: Colors.cyan,
        child: GestureDetector(
          child: Text(
            style: TextStyle(color: Colors.white, fontSize: 30),
            "PatRecords",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddRecord()),
            );
          },
        ),
      )),
    );
  }
}
