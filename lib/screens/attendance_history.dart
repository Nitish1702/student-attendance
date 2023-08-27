import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  late final DocumentSnapshot snap;
  AttendanceHistoryScreen({required this.snap});
  @override
  _AttendanceHistoryScreenState createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final sub_list = ['Math', 'Physics', 'Biology', 'Chemistry', 'Hindi', 'English'];
  DateTime selectedDate = DateTime.now(); // Step 1: Selected date variable

  @override
  void initState() {
    super.initState();
    // Initialize 'snap' here if needed
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context), // Step 2: Show DatePicker
          child: Text('Select Date'),
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('students')
                .doc(widget.snap['uid'])
                .collection('history')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Step 3: Filter attendance records based on selected date
                final filteredRecords = snapshot.data!.docs.where((record) {
                  DateTime recordDate = (record['date'] as Timestamp).toDate();
                  return recordDate.year == selectedDate.year &&
                      recordDate.month == selectedDate.month &&
                      recordDate.day == selectedDate.day;
                }).toList();


                return ListView.builder(
                  itemCount: sub_list.length,
                  itemBuilder: (context, index) {
                    final record = filteredRecords[0].data() as Map<String, dynamic>;
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: record[sub_list[index]] == 'Present'
                              ? Colors.green
                              : Colors.red,
                          child: Icon(
                            record[sub_list[index]] == 'Present' ? Icons.check : Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(sub_list[index] as String),
                        subtitle: Text('Date: ${selectedDate}'),
                        trailing: Text(record[sub_list[index]] as String),
                      ),
                    );
                  },
                );
              } else {
                return Container(child: Text('History not found'));
              }
            },
          ),
        ),
      ],
    );
  }
}
