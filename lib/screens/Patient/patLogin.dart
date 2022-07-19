import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/components/phoneNumberTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Patient/patRegister.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/utils/showSnackBar.dart';
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
                                  PhoneNumberTextField(
                                      regionController: regionController,
                                      phoneController: phoneController)
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
                              label: otpcodesent == false ? "Verify" : "Login",
                              children: SizedBox.shrink(),
                            )
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
          showSnackBar(context, "OTP Sent");
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
