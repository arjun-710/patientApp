import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Patient/providers/bottomNavigation.dart';
import 'package:provider/provider.dart';

class CustomNavigation extends StatelessWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<String> iconList;
  const CustomNavigation(
      {Key? key,
      this.defaultSelectedIndex = 0,
      required this.iconList,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItemList = [];
    Widget buildNavBarItem(String assetPath, int index) {
      return Flexible(
        child: GestureDetector(
          onTap: () {
            context.read<PatBottomNavigation>().setCurrentIndex(index);
          },
          child: Container(
            height: 65,
            width: MediaQuery.of(context).size.width / iconList.length,
            decoration:
                index == context.read<PatBottomNavigation>().currentIndex
                    ? BoxDecoration(
                        color: kNavColor,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      )
                    : const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding * 1.25),
              child: SvgPicture.asset(
                assetPath,
              ),
            ),
          ),
        ),
      );
    }

    for (var i = 0; i < iconList.length; i++) {
      navBarItemList.add(buildNavBarItem(iconList[i], i));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.only(top: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius * 2),
        ),
        child: Row(
          children: navBarItemList,
        ),
      ),
    );
  }
}
