import 'package:flutter/material.dart';
import 'package:student_attendance/custom_card/active_class.dart';
import 'package:student_attendance/custom_card/upcomming_class.dart';
class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [ActiveClass(),UpcommingClass()]),

    );
  }
}
