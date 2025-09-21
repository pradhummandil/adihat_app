import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/Login_screen.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(Login_screen(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 300));
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          color: Color(0xffA1D8FF),
          child: Center(
              child: Image.asset(
            "assets/images/splashscreen_logo.png",
            width: size / 2.5,
          )),
        ),
      ),
    );
  }
}
