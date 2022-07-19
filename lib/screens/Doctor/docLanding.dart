import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/Tabs/docAlarm.dart';
import 'package:patient_app/screens/Doctor/Tabs/docHome.dart';
import 'package:patient_app/screens/Doctor/Tabs/docPatient.dart';
import 'package:patient_app/screens/Doctor/Tabs/docRecords.dart';
import 'package:patient_app/screens/Doctor/components/docBottomNavigation.dart';
import 'package:patient_app/screens/Doctor/providers/docbottomNavigation.dart';
import 'package:provider/provider.dart';

class DocLanding extends StatefulWidget {
  @override
  _DocLandingState createState() => _DocLandingState();
}

class _DocLandingState extends State<DocLanding> {
  var currentTab = [
    DocHome(),
    DocAlarm(),
    DocRecords(),
    DocPatient(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTab[context.watch<DocBottomNavigation>().currentIndex],
      bottomNavigationBar: CustomNavigation(
        iconList: const [
          kHomeLogo,
          kAlarmLogo,
          kRecordsLogo,
          kPatient,
        ],
        onChange: (index) {
          context.read<DocBottomNavigation>().setCurrentIndex(index);
        },
        defaultSelectedIndex: 0,
      ),
    );
  }
}
