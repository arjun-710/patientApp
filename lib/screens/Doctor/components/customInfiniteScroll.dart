import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/utils/colors_util.dart';

class CustomInfinteScroll extends StatefulWidget {
  final List<int> list;
  final Function callback;
  final int? itemCount;
  final double initialScroll;
  const CustomInfinteScroll({
    Key? key,
    required this.list,
    required this.callback,
    this.itemCount,
    required this.initialScroll,
  }) : super(key: key);

  @override
  State<CustomInfinteScroll> createState() =>
      _CustomInfinteScrollState(list, callback, itemCount, initialScroll);
}

class _CustomInfinteScrollState extends State<CustomInfinteScroll> {
  double width = 0.0;
  double height = 0.0;
  final List<int> list;
  final double initialScroll;
  final Function callback;
  final int? itemCount;
  int currIdx = -1;
  late ScrollController scrollController;
  _CustomInfinteScrollState(
      this.list, this.callback, this.itemCount, this.initialScroll);

  @override
  void initState() {
    scrollController =
        ScrollController(initialScrollOffset: initialScroll * list.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: 66,
      height: height / 4,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount ?? null,
        itemBuilder: (BuildContext context, int index) {
          final i = index % list.length;
          bool theone = false;
          if (currIdx != -1) theone = list[i] == list[currIdx];

          return Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 11),
                child: GestureDetector(
                  onTap: () {
                    callback(i);
                    this.setState(() {
                      currIdx = i;
                    });
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: theone ? kPrimaryColor : HexColor("EFF6FC"),
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(list[i].toString(),
                              style: TextStyle(
                                fontSize: kh3size,
                                fontWeight: kh3FontWeight,
                                color:
                                    theone ? Colors.white : HexColor("465876"),
                              )),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
