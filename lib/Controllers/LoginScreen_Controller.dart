


import 'package:ecommerce_app_getx/AlertMsg/snackbaralert.dart';
import 'package:ecommerce_app_getx/views/Authtentication/OTP_verfication_screen.dart';
import 'package:ecommerce_app_getx/views/Home/Homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController phone = TextEditingController();
  final TextEditingController otp = TextEditingController();
  String verificationId = '';
  bool isloading = false;

  void verifyPhoneNumber() async {
    isloading = true;

    update();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+92${phone.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          showSnackbar('Verified');
        },
        verificationFailed: (FirebaseAuthException exception) {
          showSnackbar('Verification Failed');
        },
        codeSent: (String _verificationId, int? forceRespondToken) {
          showSnackbar("Verification Code Sent");

          verificationId = _verificationId;
          Get.to(() => OTPVerficationScreen());
        },
        codeAutoRetrievalTimeout: (String _verificationId) {
          verificationId = _verificationId;
        },
      );
    } catch (e) {
      showSnackbar('Error Occured: $e');
    }
  }

  void signInwithphoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp.text,
      );

      var signInUser = await _auth.signInWithCredential(credential);
      final User? user = signInUser.user;
      showSnackbar("Sign in Successfully, User UID ${user!.uid}");
      Get.to(() =>  HomeScreen());
    } catch (e) {
      showSnackbar('Error Occured: $e');
    }
  }
}
