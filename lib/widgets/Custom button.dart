import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final BorderRadius? radius;
  final Function func;
  final double butonWidth;

  const CustomButton(
      {Key? key,
      required this.text,
      this.radius,
      required this.func,
      required this.butonWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => func(),
      child: Material(
        
        elevation: 5,
        
        
        borderRadius: radius ?? BorderRadius.circular(20),
      color: Colors.blue,
      child: SizedBox(
        height: size.height /17,
        width: size.width/butonWidth,
     child: Center(
       child: Text(
         text,
         style: TextStyle(
           color: Colors.white,
           fontSize: size.width/22,
           fontWeight: FontWeight.w500,
         ),
       ),
     ),
      ),
     
      ),
    );
  }
}
