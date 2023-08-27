import 'package:flutter/material.dart';
import 'package:student_attendance/resources/time_table.dart';

void main() {
  runApp(TimetablePage());
}

class TimetablePage extends StatefulWidget {
  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  List<String> dayList = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  late final Map<String,dynamic> _tt;
  currentDay() async{
    String x = dayList[DateTime.now().weekday - 2];
    Map<String, dynamic> tt =await TimeTable().getTimeTable(x);
    setState(() {
      _tt=tt;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDay();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timetable'),
        ),
        body: TimetableScreen(_tt),
      ),
    );
  }
}

class TimetableScreen extends StatelessWidget {
  final Map<String, dynamic> _tt;

  TimetableScreen(this._tt);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: _tt.length, // Replace with the actual number of classes
      itemBuilder: (context, index) {
        String time= _tt.keys.elementAt(index);
        dynamic content=_tt[time]??[];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListTile(
            title: Text('Class ${index + 1}- ${content[0]}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Time: ${time}'),
                Text('Room: ${content[4]}'),
                Text('Teacher:${content[3]}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
