import 'package:flutter/material.dart';

class CustomPainterExampless extends StatelessWidget {
  const CustomPainterExampless({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Painter Demo")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(size: Size(150, 150), painter: SimpleCirclePainter()),
            SizedBox(height: 20),
            CustomPaint(size: Size(150, 150), painter: LinePainter()),
            SizedBox(height: 20),
            CustomPaint(size: Size(150, 150), painter: RectanglePainter()),
          ],
        ),
      ),
    );
  }
}

//Circleeee
class SimpleCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(SimpleCirclePainter oldDelegate) => false;
}

//lineee
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}

//rectangleee
class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 200,
        height: 150,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(RectanglePainter oldDelegate) => false;
}
