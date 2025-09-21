import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:adihat_doctor_app/view/screens/Details/Patient_details_screen.dart';

class loading_screen extends StatefulWidget {
  const loading_screen({super.key});

  @override
  State<loading_screen> createState() => _loading_screenState();
}

class _loading_screenState extends State<loading_screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffA1D8FF),
                    Colors.white,
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/adihatlogo_blue.png",
                  width: size / 4,
                ),
                SizedBox(
                  height: size / 8,
                ),
                Text(
                  textAlign: TextAlign.center,
                  '"Your Patient\'s Wellness\nJust Moments Away..."',
                  style: TextStyle(
                    color: Color(0xFF005AC4),
                    fontWeight: FontWeight.w600,
                    fontSize: size / 18,
                  ),
                ),
                SizedBox(
                  height: size / 3,
                ),
                Center(
                    child: Lottie.asset("assets/animations/doctor_lottie.json",
                        width: size / 1.5))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
