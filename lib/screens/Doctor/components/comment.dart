import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String? id;
  final Map<String, dynamic>? data;
  const Comment({Key? key, required this.id, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
