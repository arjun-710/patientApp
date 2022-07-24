import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/doctorUser.dart';
import 'package:patient_app/services/patientUser.dart';
import 'package:patient_app/utils/showSnackBar.dart';

class AddPrescription extends StatefulWidget {
  final String patId;
  final List medicines;
  const AddPrescription(
      {Key? key, required this.patId, required this.medicines})
      : super(key: key);

  @override
  State<AddPrescription> createState() =>
      _AddPrescriptionState(patId, medicines);
}

class _AddPrescriptionState extends State<AddPrescription> {
  _AddPrescriptionState(this.patId, this.medicines);
  final String patId;
  List medicines;
  TextEditingController _medName = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _frequency = TextEditingController();
  void removeItem(int index) async {
    log("called delete");
    PatientUser service = PatientUser();
    medicines = List.from(medicines)..removeAt(index);
    await service.removePrescription(medicines, patId);
    showSnackBar(context, "medicine removed");
    _medName.clear();
    _quantity.clear();
    _frequency.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  H2Text(text: "Add Perscription"),
                ],
              ),
              SizedBox(height: 40),
              CustomTextField(controller: _medName, hintText: "Med Name"),
              SizedBox(height: 10),
              CustomTextField(
                  keyType: TextInputType.number,
                  controller: _quantity,
                  hintText: "Quantity"),
              SizedBox(height: 10),
              CustomTextField(
                  keyType: TextInputType.number,
                  controller: _frequency,
                  hintText: "Frequency"),
              SizedBox(height: 30),
              CustomTextButton(
                  onTap: () async {
                    this.setState(() {
                      medicines.add({
                        "medName": _medName.text,
                        "quantity": int.parse(_quantity.text),
                        "frequency": int.parse(_frequency.text),
                      });
                    });

                    PatientUser service = PatientUser();
                    await service.addPrescription(
                        _medName.text,
                        int.parse(_quantity.text),
                        int.parse(_frequency.text),
                        patId);
                    showSnackBar(context, "prescription updated");
                    _medName.clear();
                    _quantity.clear();
                    _frequency.clear();
                  },
                  label: "Add Medicine",
                  children: SvgPicture.asset(kAdd)),
              SizedBox(height: 40),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView.separated(
                    itemCount: medicines.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) {
                      return AssignedMed(
                        medicines: medicines,
                        index: index,
                        onDelete: () => removeItem(index),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class AssignedMed extends StatelessWidget {
  final List medicines;
  final int index;
  final VoidCallback onDelete;
  const AssignedMed(
      {Key? key,
      required this.medicines,
      required this.index,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kCream, borderRadius: BorderRadius.circular(kBorderRadius)),
      child: ListTile(
        onLongPress: this.onDelete,
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
                    borderRadius: BorderRadius.circular(kBorderRadius)),
                child: SvgPicture.asset(kCheckUp))
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(left: 2, bottom: 2),
          child: Text(
            "${medicines[index]?["quantity"].toString() ?? ""} units/ml",
          ),
        ),
        minLeadingWidth: 20,
        title: Padding(
          padding: EdgeInsets.only(left: 2, bottom: 2),
          child: Text(
            medicines[index]?["medName"] ?? "",
          ),
        ),
        trailing: Text(
          "${medicines[index]?["frequency"].toString() ?? ""} times/day",
        ),
      ),
    );
  }
}
