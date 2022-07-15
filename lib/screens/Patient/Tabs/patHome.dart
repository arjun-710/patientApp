import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';

class PatHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("GoodMorning,",
                            style: TextStyle(fontSize: kh2size)),
                        Text("Ms Leny", style: TextStyle(fontSize: kh1Size)),
                      ],
                    ),
                    SvgPicture.asset(kLogo, width: 80, height: 80)
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: kPatCardColor,
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 32.0, left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Doctor incharge",
                              style: TextStyle(fontSize: kh3size),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Dr. Park",
                              style: TextStyle(fontSize: kh2size),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  kTimeLogo,
                                  // color: kStrokeColor,
                                ),
                                const SizedBox(width: 10.0),
                                const Text(
                                  "Next visit at 4pm",
                                  style: TextStyle(
                                      fontSize: kh4size, color: kStrokeColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: SvgPicture.asset(
                          kDocCircle,
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Continue Reading",
                      style: TextStyle(fontSize: kh2size),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Image.asset(kBook1),
                          Image.asset(kBook2),
                          Image.asset(kBook3),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: kMedCardColor,
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 25.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(kClockLogo),
                          const SizedBox(width: 14.12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Medicine time in",
                                style: TextStyle(fontSize: kh4size),
                              ),
                              Text(
                                "50min.",
                                style: TextStyle(fontSize: kh3size),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SvgPicture.asset(kRight)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
