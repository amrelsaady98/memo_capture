import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo_capture/configs/theme/colors.dart';

class ScreenOverlayMask extends StatelessWidget {
  const ScreenOverlayMask({
    super.key,
    required this.offset,
    required this.radius,
  });
  final Offset offset;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: HolePainter(offset: offset, radius: radius),
      willChange: false,
    );
  }
}

class HolePainter extends CustomPainter {
  const HolePainter({
    required this.offset,
    required this.radius,
  });
  final Offset offset;
  final double radius;
  @override
  void paint(Canvas canvas, Size size) async {
    final paint = Paint();

    paint.color = Colors.black.withOpacity(0.6);

    // paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawPath(
      Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.largest),
          Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(offset.dx + radius, offset.dy + radius),
                radius: radius,
              ),
            )),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
