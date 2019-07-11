library flutter_speedometer;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'src/painter.dart';

class Speedometer extends StatefulWidget {
  Speedometer(
      {Key key,
      this.size = 200,
      this.minValue = 0,
      this.maxValue = 100,
      this.currentValue = 0,
      this.warningValue = 80,
      this.backgroundColor = Colors.black,
      this.meterColor = Colors.lightGreenAccent,
      this.warningColor = Colors.redAccent,
      this.kimColor = Colors.white,
      this.displayNumericStyle,
      this.displayText = '',
      this.displayTextStyle})
      : super(key: key);
  final double size;
  final int minValue;
  final int maxValue;
  final int currentValue;
  final int warningValue;
  final Color backgroundColor;
  final Color meterColor;
  final Color warningColor;
  final Color kimColor;
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
    int _minValue = widget.minValue;
    int _maxValue = widget.maxValue;
    int _currentValue = widget.currentValue;
    int _warningValue = widget.warningValue;
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

    double startAngle2 = 0.0;
    double endAngle2 = 18.0;
    double _warningAngle = endAngle2;
    if (_minValue <= _warningValue && _warningValue <= _maxValue) {
      _warningAngle =
          (((_warningValue - _minValue) * (endAngle2 - startAngle2)) /
                  (_maxValue - _minValue)) +
              startAngle2;
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
                  padding: EdgeInsets.all(_size * 0.075),
                  child: Stack(children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        width: _size,
                        height: _size,
                        decoration: new BoxDecoration(
                          color: widget.backgroundColor,
                          boxShadow: [
                            new BoxShadow(
                                color: widget.kimColor,
                                blurRadius: 8.0,
                                spreadRadius: 4.0)
                          ],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: Size(_size, _size),
                      painter: ArcPainter(
                          startAngle: 9,
                          sweepAngle: 18,
                          color: widget.warningColor),
                    ),
                    CustomPaint(
                      size: Size(_size, _size),
                      painter: ArcPainter(
                          startAngle: 9,
                          sweepAngle: _warningAngle,
                          color: widget.meterColor),
                    ),
                  ]),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      width: _size,
                      height: _size * 0.5,
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
                    angle: math.pi / 12 * _kimAngle,
                    child: ClipPath(
                      clipper: KimClipper(),
                      child: Container(
                        width: _size * 0.9,
                        height: _size * 0.9,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
