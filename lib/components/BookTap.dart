import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';

class BookTap extends StatelessWidget {
  final Function()? onTap;
  final String assetPath;
  const BookTap({Key? key, required this.onTap, required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(kBorderRadius)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kBorderRadius),
          child: Image.asset(assetPath),
        ),
      ),
    );
  }
}
