import 'package:flutter/material.dart';
import 'package:patient_app/screens/Doctor/components/PatList.dart';

class DocHome extends StatelessWidget {
  const DocHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PatList(),
    );
  }
}
