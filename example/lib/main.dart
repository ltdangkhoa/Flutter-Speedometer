import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';

void main() {
  runApp(
    Center(
      child: Speedometer(
        size: 250,
        currentValue: 76,
        minValue: 0,
        maxValue: 180,
        backgroundColor: Colors.black,
        meterColor: Colors.blueAccent,
        kimColor: Colors.tealAccent,
        displayNumericStyle: TextStyle(
            fontFamily: 'Digital-Display',
            color: Colors.white,
            fontSize: 250 * 0.25),
        displayText: 'mph',
        displayTextStyle: TextStyle(color: Colors.white, fontSize: 250 * 0.075),
      ),
    ),
  );
}
