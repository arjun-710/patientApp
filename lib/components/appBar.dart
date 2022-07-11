import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';

class DefaultAppBar {
  AppBar appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      title: const Text(
        "DoctApp",
        style: TextStyle(color: kAppBarTextColor),
      ),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Icon(Icons.search),
        ),
        Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Icon(Icons.notifications),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
