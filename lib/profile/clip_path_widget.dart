import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, -size.height)
      ..lineTo(size.width * 0.02, size.height)
      ..lineTo(size.width * 0.98, size.height)
      ..lineTo(size.width, -size.height)
      ..lineTo(0.0, -size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}