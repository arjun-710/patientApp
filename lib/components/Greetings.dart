import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';

class Greetings extends StatelessWidget {
  final String greet;
  final String personName;

  const Greetings({
    Key? key,
    required this.greet,
    required this.personName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(greet, style: TextStyle(fontSize: kh2size)),
            Text(personName, style: TextStyle(fontSize: kh1Size)),
          ],
        ),
        GestureDetector(
            onTap: () {
              AuthService service = AuthService(FirebaseAuth.instance);
              service.signOut(context);
            },
            child: SvgPicture.asset(kProfile))
      ],
    );
  }
}
