import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TimeTable {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  createTimeTable()async {
    CollectionReference ref=await _firestore.collection('timeTable');

    await ref.doc('Monday').set(
        {
          TimeOfDay(hour: 9, minute: 0).toString(): ['Math',0,0,'Ram','101'],
          TimeOfDay(hour: 10, minute: 30).toString():['Physics',0,0,'Ram','101'],
          TimeOfDay(hour: 13, minute: 0).toString(): ['Hindi',0,0,'Rahul','101'],
          TimeOfDay(hour: 14, minute: 0).toString():['Chemistry',0,0,'Ram','101'],
          TimeOfDay(hour: 15, minute: 30).toString(): ['Biology',0,0,'Shyam','101'],
        }
    );
    await ref.doc('Tuesday').set(
        {
          TimeOfDay(hour: 9, minute: 0).toString(): ['Math',0,0,'Ram','101'],
          TimeOfDay(hour: 10, minute: 30).toString():['Physics',0,0,'Ram','101'],
          TimeOfDay(hour: 13, minute: 0).toString(): ['Hindi',0,0,'Rahul','101'],
          TimeOfDay(hour: 14, minute: 0).toString():['Chemistry',0,0,'Ram','101'],
          TimeOfDay(hour: 15, minute: 30).toString(): ['English',0,0,'Ram','101'],
        }
    );
    await ref.doc('Wednesday').set(
        {
          TimeOfDay(hour: 9, minute: 0).toString(): ['Math',0,0,'Ram','101'],
          TimeOfDay(hour: 10, minute: 30).toString():['Physics',0,0,'Ram','101'],
          TimeOfDay(hour: 13, minute: 0).toString(): ['Hindi',0,0,'Ram','101'],
          TimeOfDay(hour: 14, minute: 0).toString():['Chemistry',0,0,'Ram','101'],
          TimeOfDay(hour: 15, minute: 30).toString(): ['Biology',0,0,'Gotu','101'],
        }
    );
    await ref.doc('Thursday').set(
        {
          TimeOfDay(hour: 9, minute: 0).toString(): ['Math',0,0,'Ram','101'],
          TimeOfDay(hour: 10, minute: 30).toString():['Physics',0,0,'Ram','101'],
          TimeOfDay(hour: 13, minute: 0).toString(): ['Hindi',0,0,'Ram','101'],
          TimeOfDay(hour: 14, minute: 0).toString():['Chemistry',0,0,'Ram','101'],
          TimeOfDay(hour: 15, minute: 30).toString(): ['English',0,0,'Sheela','101'],
        }
    );
    await ref.doc('Friday').set(
        {
          TimeOfDay(hour: 9, minute: 0).toString(): ['Physics',0,0,'Ram','101'],
          TimeOfDay(hour: 10, minute: 30).toString():['Math',0,0,'Baju','101'],
          TimeOfDay(hour: 13, minute: 0).toString(): ['Hindi',0,0,'Ram','101'],
          TimeOfDay(hour: 14, minute: 0).toString():['Chemistry',0,0,'Ram','101'],
          TimeOfDay(hour: 15, minute: 30).toString(): ['English',0,0,'Sheela','101'],
        }
    );
    await ref.doc('Saturday').set(
        {
          TimeOfDay(hour: 9, minute: 0).toString(): ['Biology',0,0,'Gotu','101'],
          TimeOfDay(hour: 10, minute: 30).toString():['Physics',0,0,'Ram','101'],
          TimeOfDay(hour: 13, minute: 0).toString(): ['English',0,0,'Sheela','101'],
          TimeOfDay(hour: 14, minute: 0).toString():['Chemistry',0,0,'Ram','101'],
          TimeOfDay(hour: 15, minute: 30).toString(): ['Hindi',0,0,'Ram','101'],
        }
    );

  }
  Map<TimeOfDay, List> convertMapToTimeTable(Map<String, dynamic> map) {
    Map<TimeOfDay, List> convertedMap = {};
    map.forEach((key, value) {
      List dataList = value as List;
      TimeOfDay time = TimeOfDay(
        hour: int.parse(key.split(':')[0]),
        minute: int.parse(key.split(':')[1]),
      );
      convertedMap[time] = dataList;
    });
    return convertedMap;
  }
  Future<Map<String, dynamic>> getTimeTable(String day)async{
    // createTimeTable();
    CollectionReference ref =await _firestore.collection('timeTable');
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await ref.doc(day).get() as DocumentSnapshot<Map<String, dynamic>>;
    Map<String, dynamic> data = snapshot.data() ?? {};
    // Map<TimeOfDay, List> timetable = convertMapToTimeTable(data);
    // print(data);
    return data;

  }

}
