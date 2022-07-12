import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/constants.dart';

class PatLogin extends StatefulWidget {
  const PatLogin({Key? key}) : super(key: key);

  @override
  State<PatLogin> createState() => _PatLoginState();
}

class _PatLoginState extends State<PatLogin> {
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
        Navigator.pushNamed(context, '/patRegister');
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(width: 2.0, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  // keyboardType: TextInputType.number,
                  controller: phoneController,
                  decoration: const InputDecoration(
                      hintText: "Phone", border: InputBorder.none),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Visibility(
            visible: otpcodesent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(width: 2.0, color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    decoration: const InputDecoration(
                        hintText: "Phone", border: InputBorder.none),
                  ),
                ),
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
      Navigator.pushNamed(context, '/patRegister');
    });
  }
}
