import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:almare_gelato/widgets/customer_drawer.dart';

class StampViewScreen extends StatelessWidget {
  const StampViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stamp View'),
        ),
        drawer: const CustomDrawer(),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(50),
          crossAxisSpacing: 0,
          mainAxisSpacing: 20,
          crossAxisCount: 3,
          children: <Widget>[
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
            CustomPaint(
              painter: ConePainter(),
            ),
          ],
        )
        // body: CustomPaint(
        //   painter: ConePainter(),
        //   child: Container(),
        // ),
        // body: const Center(
        //   child: Text('This is the Stamp View screen.'),
        // ),
        );
  }
}

class ConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.getLocalClipBounds();
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const radius = 23.5;

    var centerx = (size.width / 2) - (radius / 2);
    var centery = (size.height / 2) - 50;

    var leftx = centerx + radius * cos(pi / 6);
    var lefty = centery + radius * sin(pi / 6);

    var rightx = centerx - radius * cos(-pi / 6);
    var righty = centery - radius * sin(-pi / 6);

    canvas.drawLine(Offset(leftx, lefty), Offset(centerx, radius * 2), paint);
    canvas.drawLine(Offset(rightx, righty), Offset(centerx, radius * 2), paint);
    canvas.drawCircle(Offset(centerx, centery), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
