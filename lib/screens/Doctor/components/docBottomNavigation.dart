import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/providers/docbottomNavigation.dart';
import 'package:provider/provider.dart';

class DocCustomNavigation extends StatelessWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<String> iconList;
  const DocCustomNavigation(
      {Key? key,
      this.defaultSelectedIndex = 0,
      required this.iconList,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItemList = [];
    Widget buildNavBarItem(String assetPath, int index) {
      return GestureDetector(
        onTap: () {
          context.read<DocBottomNavigation>().setCurrentIndex(index);
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width / iconList.length,
          decoration: index == context.read<DocBottomNavigation>().currentIndex
              ? BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(width: 4, color: kPrimaryColor),
                  ),
                  gradient: LinearGradient(colors: [
                    kPrimaryColor.withOpacity(0.3),
                    kPrimaryColor.withOpacity(0.015),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
                  // color: index == _selectedItemIndex ? Colors.green : Colors.white,
                  )
              : const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              assetPath,
              color: index == context.read<DocBottomNavigation>().currentIndex
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        ),
      );
    }

    for (var i = 0; i < iconList.length; i++) {
      navBarItemList.add(buildNavBarItem(iconList[i], i));
    }

    return Container(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      decoration: BoxDecoration(
        color: const Color(0xffEFF6FC),
        borderRadius: BorderRadius.circular(kBorderRadius * 2),
      ),
      child: Row(
        children: navBarItemList,
      ),
    );
  }
}
