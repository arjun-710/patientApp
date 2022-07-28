import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/ViewComment.dart';

class PatList extends StatelessWidget {
  const PatList({Key? key}) : super(key: key);
  Widget CustomText(data) {
    return H4Text(text: data);
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _patStream =
        FirebaseFirestore.instance.collection('patients').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _patStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewComments(id: document.id)));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset(kCheckUp)],
              ),
              minLeadingWidth: 20,
              title: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: H3Text(text: data["name"]),
              ),
              subtitle: Row(
                children: [
                  CustomText(data["ward"]),
                  CustomText(" | "),
                  CustomText(data["roomNum"]),
                  CustomText(" | "),
                  CustomText(data["bedNum"])
                ],
              ),
              trailing: H3Text(text: "4pm", weight: kh3FontWeight),
            );
          }).toList(),
        );
      },
    );
  }
}
