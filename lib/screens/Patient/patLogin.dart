import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Patient/patRegister.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:provider/provider.dart';

class PatLogin extends StatefulWidget {
  const PatLogin({Key? key}) : super(key: key);

  @override
  State<PatLogin> createState() => _PatLoginState();
}

class _PatLoginState extends State<PatLogin> {
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
        log("pat user not null");
      } else
        log("pat user null");
    });
  }

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
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 50.0,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        decoration: BoxDecoration(
                                          color: kTextFieldColor,
                                          border: Border.all(
                                              width: 2.0, color: kPrimaryColor),
                                          borderRadius: const BorderRadius.only(
                                            topLeft:
                                                Radius.circular(kBorderRadius),
                                            bottomLeft:
                                                Radius.circular(kBorderRadius),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Text("+"),
                                            const SizedBox(width: 2.0),
                                            Flexible(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: regionController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "91",
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: kDefaultPadding),
                                        decoration: BoxDecoration(
                                          color: kTextFieldColor,
                                          border: Border.all(
                                              width: 2.0, color: kPrimaryColor),
                                          borderRadius: const BorderRadius.only(
                                            topRight:
                                                Radius.circular(kBorderRadius),
                                            bottomRight:
                                                Radius.circular(kBorderRadius),
                                          ),
                                        ),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: phoneController,
                                          decoration: const InputDecoration(
                                              hintText: "Phone",
                                              border: InputBorder.none),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kTextFieldColor,
                                  border: Border.all(
                                      width: 2.0, color: kPrimaryColor),
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: otpController,
                                    decoration: const InputDecoration(
                                        hintText: "OTP",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
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
                              label: otpcodesent == false ? "Verify" : "Login")
                        ],
                      ),
                    ),
                  ),
                )
              : const PatRegister();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
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
      Navigator.pushNamed(context, '/patRegister');
    });
  }
}
