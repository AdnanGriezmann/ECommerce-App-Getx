import 'package:ecommerce_app_getx/Controllers/LoginScreen_Controller.dart';
import 'package:ecommerce_app_getx/widgets/Custom%20button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginScreenController());
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Scaffold(
            body: GetBuilder<LoginScreenController>(
                init: LoginScreenController(),
                builder: (value) {
                  
                  if (!value.isloading) {
                  return  SizedBox(
                      height: size.height,
                      width: size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Material(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(100),
                              ),
                              color: Colors.black,
                              child: SizedBox(
                                height: size.height / 2,
                                width: size.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height / 8,
                                    ),
                                    Text(
                                      'E-Commerce',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: size.width / 9,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3),
                                    ),
                                    SizedBox(height: size.height / 60),
                                    Text(" 'It,s all easy when it,s at home'",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width / 27,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: size.height / 10),
                                    SizedBox(
                                      width: size.width / 1.2,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: size.height / 10,
                                            width: size.width / 100,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: size.width / 40,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "Welcome\n",
                                              style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: size.width / 10,
                                                  fontWeight: FontWeight.w500),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "Enter the details to login/Signup.",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: size.width / 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height / 15),
                            Container(
                              alignment: Alignment.center,
                              height: size.height / 15,
                              width: size.width / 1.2,
                              padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Color.fromRGBO(9, 32, 196, 1),
                                ),
                              ),
                              child: TextField(
                                controller: controller.phone,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',
                                  counterText: '',
                                ),
                              ),
                            ),
                            SizedBox(height: size.height / 10),
                            CustomButton(
                              text: 'LOGIN/SIGNUP',
                              func: () {
                                controller.verifyPhoneNumber();
                              },
                              butonWidth: 2.8,
                              radius: BorderRadius.circular(10),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ),
    );
  }
}
