import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/PatientUser.dart';

class PatList extends StatefulWidget {
  const PatList({
    Key? key,
  }) : super(key: key);

  @override
  State<PatList> createState() => _PatListState();
}

class _PatListState extends State<PatList> {
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
    Widget CustomText(data) {
      return H4Text(text: data);
    }

    return FutureBuilder(
      future: patList,
      builder:
          (BuildContext context, AsyncSnapshot<List<PatientUser>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.separated(
              itemCount: retrievePatList!.length,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      color: kCheckUpPat,
                      borderRadius: BorderRadius.circular(kBorderRadius)),
                  child: ListTile(
                    onTap: () {},
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
                      child: H3Text(text: retrievePatList![index].name ?? ""),
                    ),
                    subtitle: Row(
                      children: [
                        CustomText("general"),
                        CustomText(" | "),
                        CustomText("R-32"),
                        CustomText(" | "),
                        CustomText("B-16")
                      ],
                    ),
                    trailing: H3Text(text: "4pm", weight: kh3FontWeight),
                  ),
                );
              });
        } else if (snapshot.connectionState == ConnectionState.done &&
            retrievePatList!.isEmpty) {
          return Center(
            child: ListView(
              children: const <Widget>[
                Align(
                    alignment: AlignmentDirectional.center,
                    child: Text('No patient available')),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
