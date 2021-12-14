import 'package:ecommerce_app_getx/views/Authtentication/LoginScreen.dart';
import 'package:ecommerce_app_getx/views/Home/Homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StillLoggedIn extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    
    if (auth.currentUser != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
