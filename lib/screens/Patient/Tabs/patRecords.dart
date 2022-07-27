import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/components/ViewRecords.dart';
import 'package:patient_app/screens/Patient/components/AddRecord.dart';
import 'package:patient_app/services/AuthService.dart';

class PatRecords extends StatefulWidget {
  @override
  State<PatRecords> createState() => _PatRecordsState();
}

class _PatRecordsState extends State<PatRecords> {
  late String? patId;

  @override
  void initState() {
    super.initState();
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    patId = user.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return ViewRecords(
      id: patId,
    );
  }
}
