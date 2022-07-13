import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/Tabs/docAlarm.dart';
import 'package:patient_app/screens/Doctor/Tabs/docHome.dart';
import 'package:patient_app/screens/Doctor/Tabs/docMessaging.dart';
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
    DocMessaging(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTab[context.watch<DocBottomNavigation>().currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<DocBottomNavigation>().currentIndex,
        onTap: (index) {
          context.read<DocBottomNavigation>().setCurrentIndex(index);
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
