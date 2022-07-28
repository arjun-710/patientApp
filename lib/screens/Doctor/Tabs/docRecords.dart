import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/ViewRecords.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';

class DocRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Patient Documents",
                          style: TextStyle(
                              fontSize: 28, fontWeight: kh3FontWeight)),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.75,
                    child: DocAssignedPat()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DocAssignedPat extends StatelessWidget {
  const DocAssignedPat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget CustomText(data) {
      return H4Text(text: data);
    }

    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    CollectionReference doctors =
        FirebaseFirestore.instance.collection('doctors');
    return FutureBuilder<DocumentSnapshot>(
      future: doctors.doc(user.phoneNumber).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> patients = [];
            if (data.isNotEmpty) {
              patients = ((data['patients'] ?? []) as List);
            }
            return ListView.separated(
              itemCount: patients.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                var data = patients[index];
                return Container(
                  decoration: BoxDecoration(
                      color: kCream,
                      borderRadius: BorderRadius.circular(kBorderRadius)),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewRecords(
                            id: data["patId"],
                          ),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius)),
                            child: SvgPicture.asset(kCheckUp))
                      ],
                    ),
                    minLeadingWidth: 20,
                    title: Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: H3Text(text: data["patName"]),
                    ),
                    subtitle: Row(
                      children: [
                        CustomText(data["patId"]),
                      ],
                    ),
                    trailing: SvgPicture.asset(kRight),
                  ),
                );
              },
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
