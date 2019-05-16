import 'package:classic_kit/classic_kit/ck_status_view.dart';
import 'package:flutter/material.dart';

class AboutPageOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
            child: Container(
                width: 260,
                height: 220,
                child: CKStatusView(
                  backgroundColor: Color(0xffdedede),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'icons/SplashIcon.png',
                            height: 70,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Flutter Browse.exe',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                              'This was built using flutter_classic_kit.\nThe original idea comes from https://github.com/Baddaboo/ClassicKit',
                              style: TextStyle(fontSize: 14, height: 1.1),
                              textAlign: TextAlign.center)
                        ]),
                  ),
                ))));
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
