import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(kDefaultMargin),
          child: const Text(
            'Hello',
            style: TextStyle(
              color: kSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
