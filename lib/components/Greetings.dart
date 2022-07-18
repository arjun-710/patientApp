import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/constants.dart';

class Greetings extends StatelessWidget {
  final String greet;
  final String personName;
  final Function()? onTap;

  Greetings(
      {Key? key,
      required this.greet,
      required this.personName,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            H3Text(text: greet),
            // Text(greet, style: TextStyle(fontSize: kh2size)),
            H1Text(text: personName)
            // Text(personName, style: TextStyle(fontSize: kh1Size)),
          ],
        ),
        GestureDetector(onTap: onTap, child: SvgPicture.asset(kProfile))
      ],
    );
  }
}
