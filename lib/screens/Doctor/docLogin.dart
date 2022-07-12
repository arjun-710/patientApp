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
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SvgPicture.asset(
              kassetName,
            ),
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: "Phone"),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Visibility(
                    visible: otpcodesent,
                    child: Container(
                      child: TextField(
                        controller: otpController,
                        decoration: const InputDecoration(labelText: "OTP"),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (otpcodesent)
                        verifyCode();
                      else
                        verifyNumber();
                    },
                    child: Text(otpcodesent == false ? "Verify" : "Login"),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
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
