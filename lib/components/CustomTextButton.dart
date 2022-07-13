import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onTap;
  final String label;

  const CustomTextButton({
    Key? key,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: queryData.size.width / 2,
        padding: const EdgeInsets.symmetric(
            horizontal: kButtonHorizontalPadding,
            vertical: kButtonVerticalPadding),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(width: 2.0, color: Colors.white),
            borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}
