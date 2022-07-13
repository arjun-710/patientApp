import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';

class DefaultAppBar {
  final String label;
  late FirebaseAuth auth;
  DefaultAppBar({required this.label}) {
    auth = FirebaseAuth.instance;
  }
  AppBar appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      title: Text(
        label,
        style: TextStyle(color: kAppBarTextColor),
      ),
      actions: <Widget>[
        // const Padding(
        //   padding: EdgeInsets.all(kDefaultPadding),
        //   child: Icon(Icons.search),
        // ),
        // const Padding(
        //   padding: EdgeInsets.all(kDefaultPadding),
        //   child: Icon(Icons.notifications),
        // ),
        GestureDetector(
          onTap: () async {
            print("tap signout");
            FirebaseAuth auth = FirebaseAuth.instance;
            await auth.signOut();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.logout_outlined),
          ),
        ),
      ],
    );
  }
}
