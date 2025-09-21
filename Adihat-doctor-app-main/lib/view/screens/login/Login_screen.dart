import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/Home_page.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffA1D8FF), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size / 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size / 4,
                  ),
                  Image.asset(
                    "assets/images/dradihat_logo.png",
                    width: size / 2,
                  ),
                  SizedBox(height: size / 10),
                  Text(
                    "“Healing Made Simple, Care Made Personal\n-smartly and safely.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size / 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4097FF),
                    ),
                  ),
                  SizedBox(height: size / 3),
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: size / 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff005AC4),
                          ),
                        ),
                        SizedBox(height: size / 35),
                        Text(
                          'Enter Phone number',
                          style: TextStyle(
                            fontSize: size / 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: size / 35),
                        TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(size / 20),
                              borderSide: BorderSide(
                                color: Colors.green.shade800,
                                width: 2.0,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "+91",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(size / 20),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: size / 30),
                        ElevatedButton(
                          onPressed: () {
                            Get.offAll(HomePage(),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 300));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            minimumSize: Size(double.infinity, size / 9),
                            backgroundColor: Color(0xff005AC4),
                          ),
                          child: Text(
                            "Send Verification Code",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: size / 25,
                            ),
                          ),
                        ),
                        SizedBox(height: size / 20),
                        Center(
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize: size / 25,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        SizedBox(height: size / 30),
                        ElevatedButton(
                          onPressed: () {
                            Get.offAll(HomePage(),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 300));
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            backgroundColor: Colors.white,
                            minimumSize: Size(double.infinity, size / 9),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google_logo.png',
                                width: size / 20,
                              ),
                              SizedBox(width: size / 35),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
