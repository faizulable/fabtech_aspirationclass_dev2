import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(Offset(0,size.height*0.50),Offset(size.width,size.height*0.50),[Color(0xfffa0202),Color(0xff050505)],[0.00,1.00]);

    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.9900000);
    path_0.lineTo(0,size.height*0.9300000);
    path_0.quadraticBezierTo(0,size.height*0.4575000,0,size.height*0.3000000);
    path_0.cubicTo(size.width*0.0433333,size.height*0.2325000,size.width*0.1233333,size.height*0.0175000,size.width*0.1666667,0);
    path_0.quadraticBezierTo(size.width*0.1883333,size.height*0.0075000,size.width*0.2600000,size.height*0.2600000);
    path_0.lineTo(size.width*0.4033333,size.height*0.0100000);
    path_0.lineTo(size.width*0.5100000,size.height*0.2500000);
    path_0.lineTo(size.width*0.6600000,size.height*0.0200000);
    path_0.lineTo(size.width*0.7566667,size.height*0.2700000);
    path_0.lineTo(size.width*0.8966667,size.height*0.0500000);
    path_0.lineTo(size.width,size.height*0.3100000);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(size.width*0.7866667,size.height*0.8100000);
    path_0.lineTo(size.width*0.6466667,size.height);
    path_0.lineTo(size.width*0.4900000,size.height*0.7700000);
    path_0.lineTo(size.width*0.3266667,size.height);
    path_0.quadraticBezierTo(size.width*0.1991667,size.height*0.8125000,size.width*0.1566667,size.height*0.7500000);
    path_0.quadraticBezierTo(size.width*0.1175000,size.height*0.8125000,0,size.height);
    canvas.drawPath(path_0, paint_0);

  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}


