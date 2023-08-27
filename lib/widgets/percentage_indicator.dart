import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularPercentIndicator extends StatelessWidget {
  const CustomCircularPercentIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30.0,
      animation: true,
      animationDuration: 1200,
      lineWidth: 7.0,
      percent: 0.4,
      center: Text(
        "40%",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
          color: Colors.blue,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.transparent,
      progressColor: Colors.blueAccent,
    );
  }
}
