import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';

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
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    // auth.signOut();
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushNamed(context, '/docRegister');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
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
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50.0,
                          child: Container(
                            padding: const EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                              color: kTextFieldColor,
                              border:
                                  Border.all(width: 2.0, color: kPrimaryColor),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(kBorderRadius),
                                bottomLeft: Radius.circular(kBorderRadius),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text("+"),
                                const SizedBox(width: 2.0),
                                Flexible(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: regionController,
                                    decoration: const InputDecoration(
                                        hintText: "91",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: kTextFieldColor,
                              border:
                                  Border.all(width: 2.0, color: kPrimaryColor),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(kBorderRadius),
                                bottomRight: Radius.circular(kBorderRadius),
                              ),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              decoration: const InputDecoration(
                                  hintText: "Phone", border: InputBorder.none),
                            ),
                          ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kTextFieldColor,
                      border: Border.all(width: 2.0, color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: otpController,
                        decoration: const InputDecoration(
                            hintText: "OTP", border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () {
                  if (otpcodesent) {
                    verifyCode();
                  } else {
                    verifyNumber();
                  }
                },
                child: Container(
                  width: queryData.size.width / 2,
                  padding: const EdgeInsets.symmetric(
                      horizontal: kButtonHorizontalPadding,
                      vertical: kButtonVerticalPadding),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(width: 2.0, color: Colors.white),
                      borderRadius: BorderRadius.circular(kBorderRadius)),
                  child: Text(otpcodesent == false ? "Verify" : "Login",
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
