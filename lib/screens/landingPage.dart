import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                kLandingLogo,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/patLogin');
                },
                child: Text("Login as Patient"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/docLogin');
                },
                child: Text("Login as Doctor"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
