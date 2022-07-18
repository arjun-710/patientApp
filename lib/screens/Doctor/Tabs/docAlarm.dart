import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomCalendar.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/addMedicineAlarm.dart';

class DocAlarm extends StatelessWidget {
  const DocAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(children: [
          CustomCalendar(),
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
