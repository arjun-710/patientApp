import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/docRegister.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:provider/provider.dart';

class DocLogin extends StatefulWidget {
  const DocLogin({Key? key}) : super(key: key);

  @override
  State<DocLogin> createState() => _DocLoginState();
}

class _DocLoginState extends State<DocLogin> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController(text: "91");
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDReceived = "";
  bool otpcodesent = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.authState,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          log(snapshot.connectionState.name);
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;

            return user == null
                ? Scaffold(
                    body: SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(kLogo),
                            const SizedBox(height: 70.0),
                            const Text(
                              'Enter mobile number',
                              style: TextStyle(
                                  fontWeight: kh4FontWeight,
                                  fontSize: kh4size,
                                  fontFamily: 'Montserrat'),
                            ),
                            const SizedBox(height: 40.0),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 80.0,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xffF5F6FA),
                                            border: Border.all(
                                                width: .25,
                                                color: Colors.black),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                bottomLeft:
                                                    Radius.circular(15.0)),
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
                                                    controller:
                                                        regionController,
                                                    hintText: "91",
                                                    keyType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          2),
                                                    ],
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 10,
                                                              vertical: 14),
                                                      filled: true,
                                                      fillColor: const Color(
                                                          0xffF5F6FA),
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                            ],
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15.0),
                                                    bottomRight:
                                                        Radius.circular(15.0)),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.75),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15.0),
                                                    bottomRight:
                                                        Radius.circular(15.0)),
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: .2),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 14),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xffF5F6FA),
                                              hintText: "Phone",
                                              hintStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Visibility(
                              visible: otpcodesent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: CustomTextField(
                                    keyType: TextInputType.number,
                                    controller: otpController,
                                    hintText: "OTP"),
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            CustomTextButton(
                              onTap: () {
                                if (otpcodesent) {
                                  verifyCode();
                                } else {
                                  verifyNumber();
                                }
                              },
                              color: k3Color,
                              label: otpcodesent == false ? "Verify" : "Login",
                              children: SizedBox.shrink(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const DocRegister();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: "+${regionController.text}${phoneController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            print("logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;

          setState(() {
            otpcodesent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP Sent'),
            ),
          );
          log("otp sent");
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDReceived, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      print("logged in successfully");
      Navigator.pushNamed(context, '/docRegister');
    });
  }
}
