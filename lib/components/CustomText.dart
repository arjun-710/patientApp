import 'package:flutter/cupertino.dart';

class H1Text extends StatelessWidget {
  final String text;
  const H1Text({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700));
  }
}

////////////////////////////////////////////////////
class H2Text extends StatelessWidget {
  final String text;
  const H2Text({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700));
  }
}

///////////////////////////////////////////////////////////
class H3Text extends StatelessWidget {
  final String text;
  final FontWeight? weight;
  const H3Text({Key? key, required this.text, this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 16, fontWeight: weight ?? FontWeight.w600));
  }
}

///////////////////////////////////////////////////////////
class H4Text extends StatelessWidget {
  final String text;
  const H4Text({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500));
  }
}
