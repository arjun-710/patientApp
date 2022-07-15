import 'package:flutter/material.dart';

class BookTap extends StatelessWidget {
  final Function()? onTap;
  final String assetPath;
  const BookTap({Key? key, required this.onTap, required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(assetPath),
    );
  }
}
