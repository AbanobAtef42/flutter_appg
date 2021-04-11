import 'package:flutter/material.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? onClicked;
  final Widget? child;
   MyButton({required this.onClicked, this.child});
  @override
  Widget build(BuildContext context) {
    return Styles.getButton(context, child, onClicked,Styles.getButtonStyle());
  }
}
