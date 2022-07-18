import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/customInfiniteScroll.dart';

class AddMedicineAlarm extends StatefulWidget {
  const AddMedicineAlarm({Key? key}) : super(key: key);

  @override
  State<AddMedicineAlarm> createState() => _AddMedicineAlarmState();
}

class _AddMedicineAlarmState extends State<AddMedicineAlarm> {
  List<int> allHours = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int _houridx = -1;

  void getHourIdx(idx) {
    this.setState(() {
      _houridx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
            CustomInfinteScroll(list: allHours, callback: getHourIdx),
          ],
        ),
      )),
    );
  }
}
