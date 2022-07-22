import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/customInfiniteScroll.dart';
import 'package:patient_app/utils/colors_util.dart';
// import 'package:patient_app/screens/Doctor/components/weekDays.dart';

class AddMedicineAlarm extends StatefulWidget {
  const AddMedicineAlarm({Key? key}) : super(key: key);

  @override
  State<AddMedicineAlarm> createState() => _AddMedicineAlarmState();
}

class _AddMedicineAlarmState extends State<AddMedicineAlarm> {
  bool isAm = true;
  List<int> allHours = [
    00,
    01,
    02,
    03,
    04,
    05,
    06,
    07,
    08,
    09,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24
  ];
  List<String> list = ['S', 'M', 'T', 'W', 'Th', 'F', 'S'];

  List<int> allMinutes = [
    00,
    01,
    02,
    03,
    04,
    05,
    06,
    07,
    08,
    09,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59
  ];
  int _houridx = -1;
  int _minidx = -1;
  bool isSun = false;
  bool isMon = false;
  bool isTue = false;
  bool isWed = false;
  bool isThu = false;
  bool isFri = false;
  bool isSat = false;
  TextEditingController medName = TextEditingController();
  TextEditingController medQuantity = TextEditingController();

  void getHourIdx(idx) {
    this.setState(() {
      _houridx = idx;
    });
  }

  void getMinuteIdx(idx) {
    this.setState(() {
      _minidx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(kLeft),
                    Text("Patient",
                        style:
                            TextStyle(fontSize: 32, fontWeight: kh3FontWeight)),
                    SvgPicture.asset(kDelete)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInfinteScroll(
                      list: allHours,
                      callback: getHourIdx,
                      initialScroll: 65.0),
                  SizedBox(width: 15),
                  H2Text(text: ":"),
                  SizedBox(width: 15),
                  CustomInfinteScroll(
                      list: allMinutes,
                      callback: getMinuteIdx,
                      initialScroll: 65),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AmPm(
                      text: "AM",
                      onTap: () {
                        this.setState(() {
                          isAm = true;
                        });
                      },
                      isAm: isAm),
                  AmPm(
                      text: "PM",
                      onTap: () {
                        this.setState(() {
                          isAm = false;
                        });
                      },
                      isAm: !isAm),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSun = !isSun;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: isSun ? kPatCardColor : HexColor("EFF6FC"),
                            borderRadius: BorderRadius.circular(kBorderRadius)),
                        child: Text("S")),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMon = !isMon;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: isMon ? kPatCardColor : HexColor("EFF6FC"),
                            borderRadius: BorderRadius.circular(kBorderRadius)),
                        child: Text("M")),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isTue = !isTue;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: isTue ? kPatCardColor : HexColor("EFF6FC"),
                            borderRadius: BorderRadius.circular(kBorderRadius)),
                        child: Text("T")),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isThu = !isThu;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: isThu ? kPatCardColor : HexColor("EFF6FC"),
                            borderRadius: BorderRadius.circular(kBorderRadius)),
                        child: Text("Th")),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFri = !isFri;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: isFri ? kPatCardColor : HexColor("EFF6FC"),
                            borderRadius: BorderRadius.circular(kBorderRadius)),
                        child: Text("F")),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSat = !isSat;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: isSat ? kPatCardColor : HexColor("EFF6FC"),
                            borderRadius: BorderRadius.circular(kBorderRadius)),
                        child: Text("S")),
                  ),
                ],
              ),
              SizedBox(height: 40),
              CustomTextField(controller: medName, hintText: "medicine Name"),
              SizedBox(height: 20),
              CustomTextField(controller: medQuantity, hintText: "Quantity"),
              SizedBox(height: 40),
              CustomTextButton(
                  onTap: () {},
                  label: "Save Alarm",
                  children: SizedBox.shrink())
            ],
          ),
        ),
      )),
    );
  }
}

class AmPm extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isAm;
  const AmPm(
      {Key? key, required this.text, required this.onTap, required this.isAm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadius),
                color: isAm ? kPatCardColor : HexColor("EFF6FC")),
            padding: EdgeInsets.all(12),
            child: Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }
}
