import 'package:ecommerce_app_getx/Controllers/LoginScreen_Controller.dart';
import 'package:ecommerce_app_getx/widgets/Custom%20button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerficationScreen extends StatelessWidget {
  const OTPVerficationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    LoginScreenController controller = Get.find();
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: size.height / 7,
                      width: size.width / 3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(1000),
                          )),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios_new,
                            size: size.width / 12, color: Colors.white),
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Verify your\n Phone Number\n",
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: size.width / 15,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text:
                              "Enter the OTP that you have \n received through SMS",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height / 15),
                  SizedBox(
                    height: size.height / 18,
                    width: size.width / 1.2,
                    child: PinCodeTextField(
                      appContext: context,
                       controller: controller.otp,
                      length: 6,
                      onChanged: (val) {},
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: size.height / 18,
                        fieldWidth: size.width / 8,
                        activeFillColor: Colors.green,
                        inactiveColor: Colors.blue,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  CustomButton(
                      text: 'Sent OTP',
                      func: () {
                        controller.signInwithphoneNumber();
                      },
                      butonWidth: 2.5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
