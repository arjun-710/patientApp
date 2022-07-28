import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomCalendar.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/addMedicineAlarm.dart';
import 'package:patient_app/services/AuthService.dart';
import '/utils/date_utils.dart' as date_util;

class DocAlarm extends StatefulWidget {
  const DocAlarm({Key? key}) : super(key: key);

  @override
  State<DocAlarm> createState() => _DocAlarmState();
}

class _DocAlarmState extends State<DocAlarm> {
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    super.initState();
  }

  void setDateTime(idx) {
    this.setState(() {
      currentDateTime = currentMonthList[idx];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    date_util.DateUtils.months[currentDateTime.month - 1] +
                        ', ' +
                        currentDateTime.year.toString(),
                    style: TextStyle(fontSize: 32, fontWeight: kh3FontWeight)),
              ],
            ),
          ),
          CustomCalendar(
            currentDateTime: currentDateTime,
            currentMonthList: currentMonthList,
            callback: setDateTime,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H3Text(text: "Medicine alarms"),
              SvgPicture.asset(kFilter)
            ],
          ),
          SizedBox(height: 20),
          CustomTextButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PatAssignedWrapper()),
                );
              },
              fullWidth: true,
              label: "Add medicine Alarm",
              children: SvgPicture.asset(kAdd))
        ]),
      ),
    );
  }
}

class PatAssignedWrapper extends StatelessWidget {
  const PatAssignedWrapper({Key? key}) : super(key: key);

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
                      Text("Create Med Alarm",
                          style: TextStyle(
                              fontSize: 28, fontWeight: kh3FontWeight)),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.25,
                    child: PatAssigned()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PatAssigned extends StatelessWidget {
  const PatAssigned({Key? key}) : super(key: key);
  Widget CustomText(data) {
    return H4Text(text: data);
  }

  void getDataFromMyApi(
      BuildContext context, String patId, String patName) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    String prescriptionId = "${user.phoneNumber}${patId}";
    List<Map<String, dynamic>> medicines = [];
    var prescriptionSnap =
        await db.collection("prescriptions").doc(prescriptionId).get();
    bool doesPrescExists = prescriptionSnap.exists;
    if (doesPrescExists) {
      List medList = prescriptionSnap.data()!["medicines"];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AddMedicineAlarm(patName: patName, medicines: medList),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AddMedicineAlarm(patName: patName, medicines: medicines),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                return Material(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kCream,
                        borderRadius: BorderRadius.circular(kBorderRadius)),
                    child: ListTile(
                      onTap: () {
                        getDataFromMyApi(
                            context, data["patId"], data["patName"]);
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
                  ),
                );
              },
            );
          }
        }

        return Text("loading");
      },
    );
  }
}
