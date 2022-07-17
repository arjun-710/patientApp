import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Widget children;
  final bool fullWidth;
  final Color color;

  const CustomTextButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.fullWidth = false,
      this.color = kPrimaryColor,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    Widget _buildChild() {
      if (children is SizedBox) {
        return SizedBox.shrink();
      }
      return SizedBox(width: 10);
    }

    checkWidth() {
      if (fullWidth) {
        return queryData.size.width;
      } else
        return queryData.size.width / 2;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: checkWidth(),
        padding: const EdgeInsets.symmetric(
            horizontal: kButtonHorizontalPadding,
            vertical: kButtonVerticalPadding),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(width: 2.0, color: Colors.white),
            borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            children,
            _buildChild(),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
