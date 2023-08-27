import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:student_attendance/models/user_model.dart';
import 'package:student_attendance/screens/mark_attendance_screen.dart';
import 'package:student_attendance/screens/timeTable_Screen.dart';

import 'attendance_history.dart';

void main() {
  runApp(StudentDashboardPage());
}

class StudentDashboardPage extends StatefulWidget {
  @override
  _StudentDashboardPageState createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('students').doc(_auth.currentUser!.uid).snapshots(),
          builder: (context,AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>  snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // print(snapshot.data!['name']);
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 40),
                        Center(
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        'assets/images/attendance.jpg'),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    snapshot.data!['name'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Registration no.- ${snapshot.data!["regno"]}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const <Widget>[
                      Tab(
                        icon: Icon(Icons.radio_button_checked,color: Colors.blueAccent,),
                      ),
                      Tab(
                        icon: Icon(Icons.history,color: Colors.blueAccent),
                      ),
                      Tab(
                        icon: Icon(Icons.table_chart,color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MarkAttendanceScreen(),
                      AttendanceHistoryScreen(snap: snapshot.data!,),
                      TimetablePage(),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
