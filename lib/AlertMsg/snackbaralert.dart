
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String msg) {
  Get.snackbar(msg, msg,
  backgroundColor: Colors.black,
  colorText: Colors.white,
  snackPosition: SnackPosition.TOP,
  margin: EdgeInsets.all(12.0),
  

  
  
  );
  
}
