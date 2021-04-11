import 'package:flutter/material.dart';

class OctagonClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    var oneThirdHeight = size.height / 2.8;
    var oneThirdWidth = size.width / 2.8;
    final path = Path()
      ..lineTo(0.0, oneThirdHeight/2.4)
      ..lineTo(0.0, oneThirdHeight * 2.4)
      ..lineTo(oneThirdWidth/2.4, size.height)
      ..lineTo(oneThirdWidth * 2.4, size.height)
      ..lineTo(size.width, oneThirdHeight * 2.4)
      ..lineTo(size.width, oneThirdHeight/2.4)
      ..lineTo(oneThirdWidth * 2.4, 0.0)
      ..lineTo(oneThirdWidth/2.4, 0.0)
      ..lineTo(0.0, oneThirdHeight/2.4)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}