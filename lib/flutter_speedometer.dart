library flutter_speedometer;

import 'dart:math';
import 'package:flutter/material.dart';

class Speedometer extends StatefulWidget {
  Speedometer(
      {Key key,
      this.currentValue = 0,
      this.minValue = 0,
      this.maxValue = 100,
      this.size = 200,
      this.backgroundColor = Colors.black,
      this.meterColor = Colors.lightGreenAccent,
      this.kimColor = Colors.white,
      this.changeColorValue = 80,
      this.changeProgressColor = const Color(0xFF5F4B8B),
      this.displayNumericStyle,
      this.displayText,
      this.displayTextStyle})
      : super(key: key);
  final int currentValue;
  final int minValue;
  final int maxValue;
  final double size;
  final Color backgroundColor;
  final Color meterColor;
  final Color kimColor;
  final int changeColorValue;
  final Color changeProgressColor;
  final TextStyle displayNumericStyle;
  final String displayText;
  final TextStyle displayTextStyle;
  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  @override
  Widget build(BuildContext context) {
    double _size = widget.size;
    int _currentValue = widget.currentValue;
    int _maxValue = widget.maxValue;
    int _minValue = widget.minValue;
    double startAngle = 3.0;
    double endAngle = 21.0;

    double _kimAngle = 0;
    if (_minValue <= _currentValue && _currentValue <= _maxValue) {
      _kimAngle = (((_currentValue - _minValue) * (endAngle - startAngle)) /
              (_maxValue - _minValue)) +
          startAngle;
    } else if (_currentValue < _minValue) {
      _kimAngle = startAngle;
    } else if (_currentValue > _maxValue) {
      _kimAngle = endAngle;
    }
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
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          width: _size - 25,
                          height: _size - 25,
                          decoration: new BoxDecoration(
                            color: widget.meterColor,
                            boxShadow: [
                              new BoxShadow(
                                  color: widget.kimColor,
                                  blurRadius: 8.0,
                                  spreadRadius: 4.0)
                            ],
                            shape: BoxShape.circle,
                          ),
                        )),
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
                          width: _size * 0.7,
                          height: _size * 0.7,
                          color: widget.backgroundColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: _size * 0.1,
                        height: _size * 0.1,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: widget.kimColor,
                          boxShadow: [
                            new BoxShadow(
                                color: widget.meterColor,
                                blurRadius: 10.0,
                                spreadRadius: 5.0)
                          ],
                          shape: BoxShape.circle,
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
                            width: _size*0.9,
                            height: _size*0.9,
                            color: widget.kimColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          widget.displayText,
                          style: widget.displayTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, _size * 0.1),
                          child: Text(
                            widget.currentValue.toString(),
                            style: widget.displayNumericStyle,
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
  bool shouldReclip(TriangleClipper oldClipper) => false;
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
  bool shouldReclip(KimClipper oldClipper) => false;
}
