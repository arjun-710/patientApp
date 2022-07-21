import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/utils/colors_util.dart';
import '/utils/colors_util.dart';

class WeekDays extends StatefulWidget {
  final Function callback;
  const WeekDays({Key? key, required this.callback}) : super(key: key);

  @override
  _WeekDaysState createState() => _WeekDaysState(callback);
}

class _WeekDaysState extends State<WeekDays> {
  double width = 0.0;
  double height = 0.0;
  final Function callback;
  late ScrollController scrollController;
  int currIdx = 0;
  List<String> list = ['S', 'M', 'T', 'W', 'Th', 'F', 'S'];
  _WeekDaysState(this.callback);

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 1.0 * list.length);
    super.initState();
  }

  Widget capsuleView(int index) {
    bool theone = list[index] == list[currIdx];
    return Padding(
        padding: const EdgeInsets.only(left: 11),
        child: GestureDetector(
          onTap: () {
            callback(index);
            this.setState(() {
              currIdx = index;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (theone) ? 52 : 46,
                height: (theone) ? 52 : 46,
                decoration: BoxDecoration(
                  color: (!theone) ? HexColor("EFF6FC") : HexColor("AADDE5"),
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        list[index].toString(),
                        style: TextStyle(
                            fontSize: (theone) ? 26 : kh3size,
                            fontWeight:
                                (theone) ? kh2FontWeight : kh3FontWeight,
                            color: (list[index] != list[currIdx])
                                ? HexColor("465876")
                                : Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: 110,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: capsuleView(index),
          );
        },
      ),
    );
  }
}
