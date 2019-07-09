import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';

void main() {
  runApp(
    Center(
      child: Speedometer(
        currentValue: 10,
        backgroundColor: Colors.black,
        displayText: 'km/h',
        displayTextColor: Colors.white,
      ),
//      child: Directionality(
//        textDirection: TextDirection.ltr,
//        child: Text(
//          '123',
//          style: TextStyle(fontFamily: 'Digital-Display', fontSize: 80),
//        ),
//      ),
    ),
  );
}
