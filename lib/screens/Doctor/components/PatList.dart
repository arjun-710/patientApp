import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
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
                    decoration: BoxDecoration(
                        color: kCheckUpPat,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: ListTile(
                      onTap: () {
                        print(retrievePatList![index]);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      leading: SvgPicture.asset(kCheckUp),
                      title: Text(retrievePatList![index].name ?? ""),
                      trailing: const Icon(Icons.arrow_right_sharp),
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
      ),
    );
  }
}
