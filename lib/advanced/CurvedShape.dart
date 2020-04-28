
import 'package:flutter/material.dart';
import 'package:luvutest/constants/config.dart';
import 'package:luvutest/constants/config.dart';


class LuvuClipper extends CustomClipper<Path> {
  final double cornerRadius = HEADER_RADIUS;
  @override
  Path getClip(Size rect) {

    Path path = new Path();
    path.lineTo(0.0, rect.height );
    path.quadraticBezierTo(0.0, rect.height -cornerRadius, cornerRadius, rect.height-cornerRadius);
    path.lineTo(rect.width - cornerRadius, rect.height-cornerRadius);
    path.quadraticBezierTo(rect.width, rect.height-cornerRadius, rect.width, rect.height - cornerRadius*2);
    path.lineTo(rect.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double cornerRadius = HEADER_RADIUS;
    Path path = new Path();
    path.lineTo(0.0, rect.height );
    path.quadraticBezierTo(0.0, rect.height -cornerRadius, cornerRadius, rect.height-cornerRadius);
    path.lineTo(rect.width - cornerRadius, rect.height-cornerRadius);
    path.quadraticBezierTo(rect.width, rect.height-cornerRadius, rect.width, rect.height - cornerRadius*2);
    path.lineTo(rect.width, 0);
    path.close();
    return path;



 /*   final double cornerRadius = 40;
    Path path = new Path();
    path.lineTo(0.0, rect.height + cornerRadius);
    path.quadraticBezierTo(0.0, rect.height, cornerRadius, rect.height);
    path.lineTo(rect.width - cornerRadius, rect.height);
    path.quadraticBezierTo(rect.width, rect.height, rect.width, rect.height - cornerRadius);
    path.lineTo(rect.width, 0);
    path.close();
    return path;*/


    //Wavy
    /*return Path()..lineTo(0, rect.height)
      ..quadraticBezierTo(rect.width / 4, rect.height + 15, rect.width / 3, rect.height)
      ..quadraticBezierTo(rect.width / 2, rect.height + 30, rect.width * 0.66, rect.height)
      ..quadraticBezierTo(rect.width * 0.75, rect.height + 15, rect.width, rect.height)
      ..lineTo(rect.width, 0)..close();*/


  }
}