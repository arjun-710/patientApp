import 'package:flutter/material.dart';
import 'package:patient_app/screens/Patient/components/patBottomNavigation.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Patient/Tabs/patAlarm.dart';
import 'package:patient_app/screens/Patient/Tabs/patBooks.dart';
import 'package:patient_app/screens/Patient/Tabs/patHome.dart';
import 'package:patient_app/screens/Patient/Tabs/patMedia.dart';
import 'package:patient_app/screens/Patient/Tabs/patRecords.dart';
import 'package:patient_app/screens/Patient/providers/bottomNavigation.dart';
import 'package:provider/provider.dart';

class PatLanding extends StatefulWidget {
  @override
  _PatLandingState createState() => _PatLandingState();
}

class _PatLandingState extends State<PatLanding> {
  var currentTab = [PatHome(), PatAlarm(), PatRecords(), PatMedia()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTab[context.watch<PatBottomNavigation>().currentIndex],
      bottomNavigationBar: CustomNavigation(
        iconList: const [
          kHomeLogo,
          // kBooksLogo,
          kAlarmLogo,
          kRecordsLogo,
          kMediaLogo
        ],
        onChange: (index) {
          context.read<PatBottomNavigation>().setCurrentIndex(index);
        },
        defaultSelectedIndex: 0,
      ),
    );
  }
}
