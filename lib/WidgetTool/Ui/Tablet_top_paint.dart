import 'package:flutter/material.dart';
import '../../Constant/ConstColor.dart';

class TabletTopPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Flip the canvas vertically
    canvas.save();
    canvas.translate(0, size.height); // Translate to the bottom of the canvas
    canvas.scale(1, -1); // Flip vertically (scaling on y-axis)

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5513889, size.height * 0.4475806);
    path_0.cubicTo(size.width * 0.2361111, size.height * 0.4475806,
        size.width * 0.05277778, size.height * 0.7701613,
        size.width * 0.001388889, size.height * 0.9979839);
    path_0.lineTo(size.width * 0.9986111, size.height * 0.9979839);
    path_0.lineTo(size.width * 0.9986111, size.height * 0.002016129);
    path_0.cubicTo(size.width * 0.9814806, size.height * 0.1586020,
        size.width * 0.8764361, size.height * 0.4475806,
        size.width * 0.5513889, size.height * 0.4475806);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = headColor.withOpacity(1.0); // Color can be changed
    canvas.drawPath(path_0, paint_0_fill);

    // Restore the canvas state after the transformation
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
