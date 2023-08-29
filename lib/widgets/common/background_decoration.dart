import 'package:flutter/material.dart';
import 'package:quizzems/configs/themes/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  const BackgroundDecoration({
    super.key,
    required this.child,
    this.showGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient() : null,
            ),
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
        ),
        Positioned.fill(child: SafeArea(child: child))
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final firstPath = Path();
    firstPath.moveTo(0, 0);
    firstPath.lineTo(size.width * 0.2, 0);
    firstPath.lineTo(0, size.height * 0.4);
    firstPath.close();

    final secondPath = Path();
    secondPath.moveTo(size.width, 0);
    secondPath.lineTo(size.width * 0.8, 0);
    secondPath.lineTo(size.width * 0.2, size.height);
    secondPath.lineTo(size.width, size.height);
    secondPath.close();

    canvas.drawPath(firstPath, paint);
    canvas.drawPath(secondPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}
