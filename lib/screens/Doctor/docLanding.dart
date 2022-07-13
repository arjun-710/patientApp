import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/Tabs/docAlarm.dart';
import 'package:patient_app/screens/Doctor/Tabs/docBooks.dart';
import 'package:patient_app/screens/Doctor/Tabs/docHome.dart';
import 'package:patient_app/screens/Doctor/Tabs/docMedia.dart';
import 'package:patient_app/screens/Doctor/Tabs/docMessaging.dart';
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
    DocBooks(),
    DocMedia(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTab[context.watch<DocBottomNavigation>().currentIndex],
      bottomNavigationBar: DocCustomNavigation(
        iconList: const [
          kHomeLogo,
          kBooksLogo,
          kMediaLogo,
        ],
        onChange: (index) {
          context.read<DocBottomNavigation>().setCurrentIndex(index);
        },
        defaultSelectedIndex: 0,
      ),
    );
  }
}
