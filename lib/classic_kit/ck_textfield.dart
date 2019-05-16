import 'package:classic_kit/classic_kit/ck_status_view.dart';
import 'package:flutter/material.dart';

class CKTextField extends StatefulWidget {
  final TextEditingController controller;

  CKTextField({Key key, @required this.controller}) : super(key: key);

  _CKTextFieldState createState() => _CKTextFieldState();
}

class _CKTextFieldState extends State<CKTextField> {
  @override
  Widget build(BuildContext context) {
    return CKStatusView(
      backgroundColor: Colors.white,
      child: TextField(
        style: TextStyle(fontSize: 14),
        controller: this.widget.controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8),
            hintStyle: TextStyle(fontSize: 14),
            hintText: 'Address',
            border: InputBorder.none),
        maxLines: 1,
      ),
    );
  }
}
