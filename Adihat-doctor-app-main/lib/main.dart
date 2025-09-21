import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adihat_doctor_app/view/screens/Details/Patient_details_screen.dart';
import 'package:adihat_doctor_app/view/screens/Loading_screen/loading_screen.dart';
import 'package:adihat_doctor_app/view/screens/home/Home_page.dart';
import 'package:adihat_doctor_app/view/screens/splash/Splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Splash_screen(),
    );
  }
}
