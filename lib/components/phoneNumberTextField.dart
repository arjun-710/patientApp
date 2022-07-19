import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    Key? key,
    required this.regionController,
    required this.phoneController,
  }) : super(key: key);

  final TextEditingController regionController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Container(
            padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              color: Color(0xffF5F6FA),
              border: Border.all(width: .25, color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0)),
            ),
            child: Row(
              children: [
                const Text(
                  "+",
                  style: TextStyle(
                    fontSize: kh3size,
                  ),
                ),
                Flexible(
                  child: CustomTextField(
                      controller: regionController,
                      hintText: "91",
                      keyType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 14),
                        filled: true,
                        fillColor: const Color(0xffF5F6FA),
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      )),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: CustomTextField(
              controller: phoneController,
              hintText: "Phone",
              keyType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.75),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  borderSide: const BorderSide(color: Colors.black, width: .2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                filled: true,
                fillColor: const Color(0xffF5F6FA),
                hintText: "Phone",
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ),
      ],
    );
  }
}
