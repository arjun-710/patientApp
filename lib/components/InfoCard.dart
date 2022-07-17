import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/constants.dart';

class InfoCard extends StatelessWidget {
  final String posType;
  final String name;
  final String nextVisit;
  final String svgPath;
  final Color color;
  final Widget child;
  const InfoCard({
    Key? key,
    required this.posType,
    required this.name,
    required this.nextVisit,
    required this.svgPath,
    required this.child,
    this.color = kPatCardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildChild() {
      if (child is SizedBox) {
        return SizedBox.shrink();
      }
      return SizedBox(height: 10);
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H3Text(text: posType, weight: kh3FontWeight),
                // Text(
                //   posType,
                //   style: const TextStyle(fontSize: kh3size),
                // ),
                const SizedBox(height: 10),
                H2Text(text: name),
                // Text(
                //   name,
                //   style: const TextStyle(fontSize: kh2size),
                // ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SvgPicture.asset(
                      kTimeLogo,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      nextVisit,
                      style: const TextStyle(
                          fontSize: kh4size, color: kStrokeColor),
                    ),
                  ],
                ),
                _buildChild(),
                child,
              ],
            ),
          ),
          Flexible(
            child: SvgPicture.asset(
              svgPath,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
