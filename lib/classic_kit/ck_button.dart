import 'package:classic_kit/classic_kit/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum CKButtonState { normal, highlighted }

class CKButton extends StatefulWidget {
  CKButtonState state;
  final bool enable;
  final Color backgroundColor;
  final Color hightlightedBackgroundColor;

  final double maxHeight;
  final double maxWidth;
  final Widget child; // should be image or text
  final GestureTapCallback onTap;

  CKButton(
      {Key key,
      this.state = CKButtonState.normal,
      this.enable = true,
      this.maxWidth = 35,
      this.maxHeight = 35,
      this.backgroundColor = const Color(0xffc0c0c0),
      this.hightlightedBackgroundColor = const Color(0xffacacac),
      this.onTap,
      @required this.child});

  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<CKButton> {
  @override
  Widget build(BuildContext context) {
    final isHighlighted = this.widget.state == CKButtonState.highlighted;
    return Container(
      constraints: BoxConstraints(
          maxWidth: this.widget.maxWidth, maxHeight: this.widget.maxHeight),
      color: Colors.white,
      child: CustomPaint(
        child: Container(
          padding: EdgeInsets.all(2 * CKConstants.bevelWidth),
          child: InkWell(
            onTap: this.widget.onTap,
            onHighlightChanged: (highlight) {
              if (!this.widget.enable) return;
              setState(() {
                this.widget.state =
                    highlight ? CKButtonState.highlighted : CKButtonState.normal;
              });
            },
            child: Opacity(
              opacity: this.widget.enable ? 1.0 : 0.5,
              child: Container(
                  alignment: Alignment.center,
                  padding: isHighlighted
                      ? EdgeInsets.only(left: 4, top: 4)
                      : EdgeInsets.zero,
                  color: this.widget.state == CKButtonState.highlighted
                      ? this.widget.hightlightedBackgroundColor
                      : this.widget.backgroundColor,
                  child: this.widget.child),
            ),
          ),
        ),
        foregroundPainter: ButtonPainter(state: this.widget.state)
      ),
    );
  }
}

class ButtonPainter extends CustomPainter {
  CKButtonState state;

  ButtonPainter({this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final lineWidth = CKConstants.bevelWidth;

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.fill
      ..strokeWidth = lineWidth;

    switch (state) {
      case CKButtonState.normal:
        {
          // outter horizontal
          paint.color = Colors.black;
          canvas.drawRect(
              Rect.fromLTWH(0, size.height - lineWidth, size.width, lineWidth),
              paint);

          // intter horizontal
          paint.color = Colors.black.withAlpha(120);
          canvas.drawRect(
              Rect.fromLTWH(lineWidth, size.height - 2 * lineWidth,
                  size.width - lineWidth, lineWidth),
              paint);

          // outter vertical
          paint.color = Colors.black;
          canvas.drawRect(
              Rect.fromLTWH(size.width - lineWidth, 0, lineWidth, size.height),
              paint);

          // inner vertical
          paint.color = Colors.black.withAlpha(120);
          canvas.drawRect(
              Rect.fromLTWH(size.width - 2 * lineWidth, lineWidth, lineWidth,
                  size.height - 3 * lineWidth),
              paint);

          break;
        }
      case CKButtonState.highlighted:
        {
          paint.color = Colors.black.withAlpha(120);
          // outter vertical
          canvas.drawRect(
              Rect.fromLTWH(0, 0, lineWidth, size.height - lineWidth), paint);

          // outter horizontal
          paint.color = Colors.black.withAlpha(120);
          canvas.drawRect(
              Rect.fromLTWH(
                  lineWidth, 0, size.width - 2 * lineWidth, lineWidth),
              paint);

          // inner horizontal
          paint.color = Colors.black;
          canvas.drawRect(
              Rect.fromLTWH(
                  lineWidth, lineWidth, size.width - 3 * lineWidth, lineWidth),
              paint);

          // innter vertical
          canvas.drawRect(
              Rect.fromLTWH(lineWidth, 2 * lineWidth, lineWidth,
                  size.height - 4 * lineWidth),
              paint);
        }
    }

    // outter top
  }

  @override
  bool shouldRepaint(ButtonPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ButtonPainter oldDelegate) => false;
}
