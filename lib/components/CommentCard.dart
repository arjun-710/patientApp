import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/utils/colors_util.dart';

class CommentCard extends StatefulWidget {
  final String? comment;
  final String? docId;
  final VoidCallback onDelete;
  const CommentCard(
      {Key? key,
      required this.comment,
      required this.docId,
      required this.onDelete})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState(onDelete);
}

class _CommentCardState extends State<CommentCard> {
  final VoidCallback onDelete;
  _CommentCardState(this.onDelete);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: this.onDelete,
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: HexColor("FEECE2"),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SvgPicture.asset(kComment),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        widget.comment.toString(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: kh2FontWeight,
                            fontSize: kh4size),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                        child: Text("By Dr. " + widget.docId.toString(),
                            style: const TextStyle(
                                fontSize: kh4size, color: Colors.black)))
                  ],
                )
              ],
            ),
          )
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     // Flexible(
          //     //       child: RichText(
          //     //         overflow: TextOverflow.ellipsis,
          //     //         strutStyle: StrutStyle(fontSize: 12.0),
          //     //         text: TextSpan(
          //     //             style: TextStyle(color: Colors.black),
          //     //             text: widget.comment.toString()),
          //     //       ),
          //     //     ),

          // FittedBox(
          //   fit: BoxFit.contain,
          //   child: Text(
          //     widget.comment.toString(),
          //     textAlign: TextAlign.justify,
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.w600,
          //         fontStyle: FontStyle.normal),
          //   ),
          // ),
          //     // Container(
          //     //   child: Text(widget.comment.toString()),
          //     //   alignment: Alignment.center,
          //     //   width: MediaQuery.of(context).size.width,
          //     //   height: MediaQuery.of(context).size.height * 0.14,
          //     //   decoration: BoxDecoration(
          //     //     color: kPrimaryColor,
          //     //     borderRadius: BorderRadius.circular(kBorderRadius),
          //     //   ),
          //     // ),
          // SizedBox(height: 5),
          // Container(
          //     child: Text("by Doctor " + widget.docId.toString(),
          //         style:
          //             const TextStyle(fontSize: kh4size, color: kStrokeColor)))
          //   ],
          // ),
          ),
    );
  }
}
