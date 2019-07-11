import 'dart:math' as math;
import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  ArcPainter(
      {this.startAngle = 0, this.sweepAngle = 0, this.color = Colors.white});
  final double startAngle;
  final double sweepAngle;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(size.width * 0.05, size.width * 0.05,
        size.width * 0.95, size.height * 0.95);
    final startAngle = math.pi / 12 * this.startAngle;
    final sweepAngle = math.pi / 12 * this.sweepAngle;
    final useCenter = false;
    final paint = Paint()
      ..color = this.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0.0);
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
    path.moveTo(size.width * 0.5, size.width * 0.5);
    path.lineTo(size.width * 0.5 + size.width / 30, size.height * 0.5);
    path.lineTo(size.width * 0.5 + 1, size.height - size.width / 30);
    path.lineTo(size.width * 0.5 - 1, size.height - size.width / 30);
    path.lineTo(size.width * 0.5 - size.width / 30, size.height * 0.5);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(KimClipper oldClipper) => false;
}
