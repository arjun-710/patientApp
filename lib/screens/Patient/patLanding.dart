import 'package:flutter/material.dart';
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
  var currentTab = [
    PatHome(),
    PatBooks(),
    PatAlarm(),
    PatRecords(),
    PatMedia()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTab[context.watch<BottomNavigation>().currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<BottomNavigation>().currentIndex,
        onTap: (index) {
          context.read<BottomNavigation>().setCurrentIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: kPrimaryColor,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            backgroundColor: kPrimaryColor,
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            backgroundColor: kPrimaryColor,
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            backgroundColor: kPrimaryColor,
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.media_bluetooth_off),
            backgroundColor: kPrimaryColor,
            label: 'Media',
          ),
        ],
      ),
    );
  }
}
