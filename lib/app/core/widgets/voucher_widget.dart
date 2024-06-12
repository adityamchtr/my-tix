import 'package:flutter/material.dart';

class VoucherWidget extends StatelessWidget {
  const VoucherWidget({super.key,
    required this.shadow,
    required this.child,
    this.positionRound = 1.55,
    this.radius = 16.0
  });

  final Shadow shadow;
  final Widget child;
  final double positionRound;
  final double radius;

  @override
  Widget build(BuildContext context) {
    var clipper = _VoucherClipper(
      positionRound: positionRound,
      radius: radius
    );

    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(
        clipper: clipper,
        child: child
      ),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  _ClipShadowShadowPainter({
    required this.shadow,
    required this.clipper
  });

  final Shadow shadow;
  final CustomClipper<Path> clipper;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _VoucherClipper extends CustomClipper<Path> {
  const _VoucherClipper({
    required this.positionRound,
    required this.radius,
  });

  final double positionRound;
  final double radius;

  @override
  Path getClip(Size size) {
    final path = Path();

    //Radius
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ),
    );


    // Left Round In
    path.addOval(
      Rect.fromCircle(
        center: Offset(0, (size.height / positionRound)), // Position Round In Left
        radius: 12.0, // Size
      ),
    );

    // Right Round In
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width, (size.height / positionRound)), // Position Round In Right
        radius: 12.0, // Size
      ),
    );

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}