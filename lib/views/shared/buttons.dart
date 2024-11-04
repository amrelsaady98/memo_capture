import 'package:flutter/material.dart';
import 'package:memo_capture/configs/theme/colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.width,
    this.height,
    required this.asset,
    this.iconColor,
    this.gridsColor,
  });

  final double? width;
  final double? height;
  final String asset;
  final Color? iconColor;
  final Color? gridsColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 36,
      width: width ?? 36,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: Size(
                height ?? 36,
                width ?? 36,
              ),
              painter: MyCustomPainter(gridsColor: gridsColor),
            ),
          ),
          Center(
            child: Image.asset(
              asset,
              height: (height ?? 36) / 3,
              width: (width ?? 36) / 3,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Color? gridsColor;

  MyCustomPainter({
    super.repaint,
    this.gridsColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint();
    linePaint.strokeWidth = 0.5;
    linePaint.color = gridsColor ?? AppColors.grid_color;
    canvas.drawLine(
      Offset(0, size.height / 3),
      Offset(size.width, size.height / 3),
      linePaint,
    );
    canvas.drawLine(
      Offset(0, 2 * size.height / 3),
      Offset(size.width, 2 * size.height / 3),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width / 3, 0),
      Offset(size.width / 3, size.height),
      linePaint,
    );
    canvas.drawLine(
      Offset(size.width * 2 / 3, 0),
      Offset(size.width * 2 / 3, size.height),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
