import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(kLogo),
              const SizedBox(height: 70.0),
              const Text(
                'login as',
                style: TextStyle(
                    fontWeight: kh1FontWeight,
                    fontSize: kh2size,
                    fontFamily: 'Montserrat'),
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/patLogin')},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: queryData.size.width / 2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: kButtonHorizontalPadding,
                        vertical: kButtonVerticalPadding),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(kBorderRadius)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(kPatLogo),
                          const SizedBox(width: 10.0),
                          const Text(
                            'Patient',
                            style: TextStyle(
                                fontWeight: kh6FontWeight,
                                fontFamily: 'Montserrat'),
                          ),
                        ],
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
                    width: queryData.size.width / 2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: kButtonHorizontalPadding,
                        vertical: kButtonVerticalPadding),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        border: Border.all(width: 2.0, color: Colors.white),
                        borderRadius: BorderRadius.circular(kBorderRadius)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(kDocLogo),
                          const SizedBox(width: 10.0),
                          const Text(
                            'Doctor',
                            style: TextStyle(
                                fontWeight: kh6FontWeight,
                                fontFamily: 'Montserrat'),
                          ),
                        ],
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
