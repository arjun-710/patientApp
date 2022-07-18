import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(kLogo),
              const SizedBox(height: 70.0),
              H3Text(text: "Login as", weight: kh3FontWeight),
              const SizedBox(height: 40.0),
              CustomTextButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/patLogin');
                  },
                  label: "Patient",
                  children: SvgPicture.asset(kPatLogo)),
              const SizedBox(height: 20.0),
              CustomTextButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/docLogin');
                  },
                  label: "Doctor",
                  children: SvgPicture.asset(kPatLogo)),
            ],
          ),
        ),
      ),
    );
  }
}
