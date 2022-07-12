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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(kLandingLogo),
              const SizedBox(height: 30.0),
              const Text(
                'Smart Table',
                style: TextStyle(fontWeight: kh1FontWeight, fontSize: kh1Size),
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/patLogin')},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kButtonHorizontalPadding,
                        vertical: kButtonVerticalPadding),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(kBorderRadius)),
                    child: const Center(
                      child: Text(
                        'Login as Patient',
                        style: TextStyle(fontWeight: kh6FontWeight),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/docLogin')},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kButtonHorizontalPadding,
                        vertical: kButtonVerticalPadding),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(kBorderRadius)),
                    child: const Center(
                      child: Text(
                        'Login as Doctor',
                        style: TextStyle(fontWeight: kh6FontWeight),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
