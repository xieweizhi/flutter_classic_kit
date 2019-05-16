import 'package:classic_kit/classic_kit/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CKStatusView extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const CKStatusView({Key key, this.backgroundColor, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(1),
        child: Container(
            color: backgroundColor ?? Color(0xffc0c0c0),
            child: CustomPaint(
                foregroundPainter: StatusViewPainter(),
                child: Center(child: child))));
  }
}

class StatusViewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lineWidth = CKConstants.bevelWidth;

    Paint paint = Paint()
      ..color = Color(0xff868686)
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.fill
      ..strokeWidth = lineWidth;

    // outter vertical
    canvas.drawRect(Rect.fromLTWH(0, 0, lineWidth, size.height), paint);

    // innter vertical
    paint.color = Colors.black;
    canvas.drawRect(
        Rect.fromLTWH(
            lineWidth, lineWidth, lineWidth, size.height - 2 * lineWidth),
        paint);

    // outter horizontal
    paint.color = Color(0xff868686);
    canvas.drawRect(
        Rect.fromLTWH(lineWidth, 0, size.width - lineWidth, lineWidth), paint);

    // innter horizontal
    paint.color = Colors.black;
    canvas.drawRect(
        Rect.fromLTWH(
            2 * lineWidth, lineWidth, size.width - 3 * lineWidth, lineWidth),
        paint);

    // right vertical
    paint.color = Color(0xffdfdfdf);
    canvas.drawRect(
        Rect.fromLTWH(size.width - lineWidth, lineWidth, lineWidth,
            size.height - lineWidth),
        paint);

    // bottom horizontal
    paint.color = Color(0xffdfdfdf);
    canvas.drawRect(
        Rect.fromLTWH(lineWidth, size.height - lineWidth,
            size.width - 2 * lineWidth, lineWidth),
        paint);
  }

  @override
  bool shouldRepaint(StatusViewPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(StatusViewPainter oldDelegate) => false;
}
