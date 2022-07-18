import 'package:flutter/material.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/utils/colors_util.dart';
import '/utils/colors_util.dart';
import '/utils/date_utils.dart' as date_util;

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 56.5 * currentDateTime.day);
    super.initState();
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ', ' +
            currentDateTime.year.toString(),
        style: TextStyle(fontSize: 32, fontWeight: kh3FontWeight),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return Container(
      width: width,
      height: 110,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: capsuleView(index),
          );
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    bool theone = currentMonthList[index].day == currentDateTime.day;
    return Padding(
        padding: const EdgeInsets.only(left: 11),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (theone) ? 66 : 56,
                height: (theone) ? 66 : 56,
                decoration: BoxDecoration(
                  color: (!theone) ? HexColor("EFF6FC") : HexColor("AADDE5"),
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        currentMonthList[index].day.toString(),
                        style: TextStyle(
                            fontSize: (theone) ? 26 : kh3size,
                            fontWeight:
                                (theone) ? kh2FontWeight : kh3FontWeight,
                            color: (currentMonthList[index].day !=
                                    currentDateTime.day)
                                ? HexColor("465876")
                                : Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.05),
              Container(
                margin:
                    (theone) ? EdgeInsets.only(bottom: 10) : EdgeInsets.all(0),
                child: Text(
                  date_util
                      .DateUtils.weekdays[currentMonthList[index].weekday - 1]
                      .substring(0, 2),
                  style: TextStyle(
                      fontSize: kh3size,
                      fontWeight: (theone) ? kh2FontWeight : kh3FontWeight,
                      color: HexColor("465876")),
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: height * 0.25,
      width: width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            titleView(),
            hrizontalCapsuleListView(),
          ]),
    );
  }
}
