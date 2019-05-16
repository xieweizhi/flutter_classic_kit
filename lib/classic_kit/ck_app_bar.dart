import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:classic_kit/classic_kit/constants.dart';

class CKAppBar extends StatefulWidget implements PreferredSizeWidget {
  CKAppBar({Key key}) : super(key: key);

  _CKAppBarState createState() => _CKAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(30);
}

class _CKAppBarState extends State<CKAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffc0c0c0),
        child: Container(
          alignment: Alignment.bottomCenter,
            child: CustomPaint(
              size: Size.fromHeight(CKConstants.bevelWidth),
          foregroundPainter: AppBarPainter(),
        )));
  }
}

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lineWidth = CKConstants.bevelWidth;

    Paint paint = Paint()
      ..color = Color(0xff868686)
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.fill
      ..strokeWidth = lineWidth;

    // upper
    canvas.drawRect(
        Rect.fromLTWH(0, size.height - 2*lineWidth, size.width, lineWidth),
        paint);
    
    // bottom
    paint.color = Color(0xffdfdfdf);
    canvas.drawRect(
        Rect.fromLTWH(0, size.height - lineWidth, size.width, lineWidth),
        paint);
  }

  @override
  bool shouldRepaint(AppBarPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(AppBarPainter oldDelegate) => false;
}
