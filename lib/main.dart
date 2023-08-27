import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_attendance/screens/dashboard.dart';
// import 'package:student_attendance/screens/dashboard.dart';
import 'package:student_attendance/screens/login_screen.dart';
import 'package:student_attendance/screens/mark_attendance_screen.dart';
import 'package:student_attendance/screens/signup_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: SignupScreen(),
      )
    );
  }
}
