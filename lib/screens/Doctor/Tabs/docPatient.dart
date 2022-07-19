import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/addPatient.dart';
import 'package:patient_app/services/patientUser.dart';

class DocPatient extends StatefulWidget {
  const DocPatient({Key? key}) : super(key: key);

  @override
  State<DocPatient> createState() => _DocPatientState();
}

class _DocPatientState extends State<DocPatient> {
  PatientUser service = PatientUser();
  Future<List<PatientUser>>? patList;
  List<PatientUser>? retrievePatList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    patList = service.getPatients();
    retrievePatList = await service.getPatients();
  }

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
                      Text("Your Patients",
                          style: TextStyle(
                              fontSize: 28, fontWeight: kh3FontWeight)),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 1.75),
                CustomTextButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddPatient()),
                      );
                    },
                    fullWidth: true,
                    label: "Add Patient",
                    children: SvgPicture.asset(kAdd))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class myPatients extends StatelessWidget {
//   const myPatients({
//     Key? key,
//     required this.patList,
//     required this.retrievePatList,
//   }) : super(key: key);

//   final Future<List<PatientUser>>? patList;
//   final List<PatientUser>? retrievePatList;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: patList,
//       builder:
//           (BuildContext context, AsyncSnapshot<List<PatientUser>> snapshot) {
//         if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//           return ListView.separated(
//               itemCount: retrievePatList!.length,
//               separatorBuilder: (context, index) => const SizedBox(
//                     height: 10,
//                   ),
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                   decoration: BoxDecoration(
//                       color: kCheckUpPat,
//                       borderRadius: BorderRadius.circular(kBorderRadius)),
//                   child: ListTile(
//                     onTap: () {},
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(kBorderRadius),
//                     ),
//                     leading: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [SvgPicture.asset(kCheckUp)],
//                     ),
//                     minLeadingWidth: 20,
//                     title: Padding(
//                       padding: EdgeInsets.only(bottom: 5),
//                       child: H3Text(text: retrievePatList![index].name ?? ""),
//                     ),
//                     subtitle: Row(
//                       children: [
//                         Text("general"),
//                         // CustomText(" | "),
//                         // CustomText("R-32"),
//                         // CustomText(" | "),
//                         // CustomText("B-16")
//                       ],
//                     ),
//                     trailing: H3Text(text: "4pm", weight: kh3FontWeight),
//                   ),
//                 );
//               });
//         } else if (snapshot.connectionState == ConnectionState.done &&
//             retrievePatList!.isEmpty) {
//           return Center(
//             child: ListView(
//               children: const <Widget>[
//                 Align(
//                     alignment: AlignmentDirectional.center,
//                     child: Text('No patient available')),
//               ],
//             ),
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
