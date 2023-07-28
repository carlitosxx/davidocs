import 'dart:math' as math;

import 'package:flutter/material.dart';

class _ClipperTopPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.addOval(Rect.fromPoints(
        Offset(-size.height, -size.height), Offset(size.width, size.height)));

    path.close();
    return path;
  }

  double degToRad(num deg) => deg * (math.pi / 180.0);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClipperTopLogin extends StatelessWidget {
  const ClipperTopLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _ClipperTopPath(),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
    );
  }
}
