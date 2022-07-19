import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomCalendar.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/addMedicineAlarm.dart';
import '/utils/date_utils.dart' as date_util;

class DocAlarm extends StatefulWidget {
  const DocAlarm({Key? key}) : super(key: key);

  @override
  State<DocAlarm> createState() => _DocAlarmState();
}

class _DocAlarmState extends State<DocAlarm> {
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    super.initState();
  }

  void setDateTime(idx) {
    this.setState(() {
      currentDateTime = currentMonthList[idx];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    date_util.DateUtils.months[currentDateTime.month - 1] +
                        ', ' +
                        currentDateTime.year.toString(),
                    style: TextStyle(fontSize: 32, fontWeight: kh3FontWeight)),
              ],
            ),
          ),
          CustomCalendar(
            currentDateTime: currentDateTime,
            currentMonthList: currentMonthList,
            callback: setDateTime,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H3Text(text: "Medicine alarms"),
              SvgPicture.asset(kFilter)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 2.35),
          CustomTextButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddMedicineAlarm()),
                );
              },
              fullWidth: true,
              label: "Add medicine Alarm",
              children: SvgPicture.asset(kAdd))
        ]),
      ),
    );
  }
}
