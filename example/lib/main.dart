import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';


void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpeedometerExample();
  }
}


class SpeedometerExample extends StatefulWidget {
  const SpeedometerExample({Key? key}) : super(key: key);
  @override
  State<SpeedometerExample> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<SpeedometerExample> {
  double _value = 58;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedometer Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Speedometer'),
        ),
        body: Center(
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              const Spacer(),
              Speedometer(
                size: 100,
                minValue: 0,
                maxValue: 60,
                currentValue: _value~/3,
                warningValue: 40,
                backgroundColor: Colors.black,
                meterColor: Colors.lightBlueAccent,
                warningColor: Colors.orange,
                kimColor: Colors.purpleAccent,
                displayNumericStyle: const TextStyle(fontFamily: 'Digital-Display', color: Colors.white, fontSize: 18),
                displayText: '°C',
                displayTextStyle: const TextStyle(color: Colors.white, fontSize: 8),
              ),
              const Spacer(),
              Speedometer(
                size: 300,
                minValue: 0,
                maxValue: 180,
                currentValue: _value.toInt(),
                warningValue: 90,
                backgroundColor: Colors.black,
                meterColor: Colors.green,
                warningColor: Colors.orange,
                kimColor: Colors.white,
                displayNumericStyle: const TextStyle( fontFamily: 'Digital-Display', color: Colors.white, fontSize: 40),
                displayText: 'km/h',
                displayTextStyle: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const Spacer(),
              const Speedometer(),
              Slider(min: 0, max: 180, value: _value, divisions: 180, onChanged: (value) => setState(() => _value = value )),
            ],
          ),
        ),
      ),
    );
  }
}
