library flutter_speedometer;

import 'dart:math';
import 'package:flutter/material.dart';

class Speedometer extends StatefulWidget {
  Speedometer(
      {Key key,
      this.currentValue = 0,
      this.maxValue = 100,
      this.size = 200,
      this.backgroundColor = const Color(0x00FFFFFF),
      this.progressColor = const Color(0xFFFA7268),
      this.changeColorValue = 80,
      this.changeProgressColor = const Color(0xFF5F4B8B),
      this.displayText,
      this.displayTextColor = Colors.black})
      : super(key: key);
  final int currentValue;
  final int maxValue;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final int changeColorValue;
  final Color changeProgressColor;
  final String displayText;
  final Color displayTextColor;
  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  @override
  Widget build(BuildContext context) {
    double _size = widget.size;
    int _speed = widget.currentValue;
    int _maxSpeed = widget.maxValue;
    String _displayText = widget.displayText;
    double startAngle = 3.0;
    double endAngle = 21.0;
    double _kimAngle = _speed <= _maxSpeed
        ? (_speed * (endAngle - startAngle) / _maxSpeed) + startAngle
        : endAngle;
//    Color _backgroundColor = widget.backgroundColor;
    return Container(
      color: widget.backgroundColor,
      child: Center(
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
                width: _size,
                height: _size,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: _size,
                      height: _size,
                      decoration: new BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                        clipper: TriangleClipper(),
                        child: Container(
                          width: _size,
                          height: _size / 2,
                          color: widget.backgroundColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Container(
                          width: _size * 0.8,
                          height: _size * 0.8,
                          color: widget.backgroundColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: pi / 12 * _kimAngle,
                        child: ClipPath(
                          clipper: KimClipper(),
                          child: Container(
                            width: _size,
                            height: _size,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Container(
                          width: _size * 0.1,
                          height: _size * 0.1,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          _displayText,
                          style: TextStyle(color: widget.displayTextColor),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, _size * 0.1),
                          child: Text(
                            _speed.toString(),
                            style: TextStyle(
                                color: widget.displayTextColor,
                                fontSize: _size * 0.1,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ))),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => true;
}

class KimClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.width / 2);
    path.lineTo(size.width / 2 + size.width / 30, size.height / 2);
    path.lineTo(size.width / 2 + 1, size.height - size.width / 30);
    path.lineTo(size.width / 2 - 1, size.height - size.width / 30);
    path.lineTo(size.width / 2 - size.width / 30, size.height / 2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(KimClipper oldClipper) => true;
}
