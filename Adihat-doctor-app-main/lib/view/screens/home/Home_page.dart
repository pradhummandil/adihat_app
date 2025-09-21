import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adihat_doctor_app/view/screens/Details/Patient_details_screen.dart';
import 'package:adihat_doctor_app/view/screens/Loading_screen/loading_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _patientIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image(
                  image: AssetImage(
                    "assets/images/dradihat_logo.png",
                  ),
                  width: size / 2.3,
                ),
                SizedBox(
                  width: size / 15,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      size / 120, size / 180, size / 12, size / 180),
                  decoration: BoxDecoration(
                    color: Color(0xffB2E4FF), // light blue background
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(50), // capsule shape
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: size / 25,
                        child: Icon(
                          Icons.person,
                          size: size / 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(width: size / 35),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. John',
                            style: TextStyle(
                              color: Color(0xff005AC4), // dark green text
                              fontWeight: FontWeight.bold,
                              fontSize: size / 25,
                            ),
                          ),
                          SizedBox(height: size / 150),
                          Text(
                            'Cardiologist',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xffA1D8FF),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffA1D8FF), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.center)),
            child: Center(
                child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter Patient ID",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size / 22,
                        color: Color(0xff005AC4)),
                  ),
                  Container(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size / 3.5, vertical: size / 35),
                    child: TextFormField(
                      controller: _patientIdController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xff005AC4),
                            ),
                            borderRadius: BorderRadius.circular(size / 25),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size / 85, horizontal: size / 25),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(size / 25),
                              borderSide: BorderSide(color: Color(0xffA1D8FF))),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(size / 25),
                          ),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  )),
                  ElevatedButton(
                    onPressed: () {
                      if (_patientIdController.text.trim().isNotEmpty) {
                        Get.dialog(
                          loading_screen(),
                          barrierDismissible: false,
                        );

                        Future.delayed(Duration(seconds: 3), () {
                          Get.back(); // Close the dialog
                          Get.to(
                              () => PatientDetailsScreen(
                                    patientId: _patientIdController.text
                                        .trim()
                                        .toUpperCase(),
                                  ),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 300));
                        });
                      } else {
                        Get.snackbar(
                          'Error',
                          'Please enter a valid Patient ID',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Text(
                      "GET DETAILS",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff005AC4)),
                  ),
                ],
              ),
            )),
          ),
        ));
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    super.dispose();
  }
}
