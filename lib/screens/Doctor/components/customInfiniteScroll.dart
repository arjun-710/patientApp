import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/utils/colors_util.dart';

class CustomInfinteScroll extends StatefulWidget {
  final List<int> list;
  final Function callback;
  const CustomInfinteScroll(
      {Key? key, required this.list, required this.callback})
      : super(key: key);

  @override
  State<CustomInfinteScroll> createState() =>
      _CustomInfinteScrollState(list, callback);
}

class _CustomInfinteScrollState extends State<CustomInfinteScroll> {
  double width = 0.0;
  double height = 0.0;
  final List<int> list;
  final Function callback;
  late ScrollController scrollController;
  _CustomInfinteScrollState(this.list, this.callback);

  @override
  void initState() {
    scrollController =
        ScrollController(initialScrollOffset: 51.1 * list.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: 70,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final i = index % list.length;
          return Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 11),
                child: GestureDetector(
                  onTap: () {
                    callback(i);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: HexColor("EFF6FC"),
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
                                color: HexColor("465876"),
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
