import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/validations/validations.dart';
import 'package:flutter_app8/values/colors.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String labelText;
  final IconData icon;
  final bool isObscure;
  final bool isHasNextFocus;
  final String obsCharacter;
  final TextInputType textInputType;

  MyTextField(
      this.textEditingController,
      this.labelText,
      this.icon,
      this.isObscure,
      this.obsCharacter,
      this.isHasNextFocus,
      this.textInputType);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  IconButton? _iconButton;
  IconData _icon = CupertinoIcons.eye_fill;
  bool _isObscure = true;

  int i = 0;

  FocusNode  focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

  }

  @override
  Widget build(BuildContext context) {
    animation = Tween(begin: 0.0, end: MediaQuery.of(context).size.width / 1.1)
        .animate(controller)
          ..addListener(() {
            setState(() {
// the state that has changed here is the animation object’s value
            });
          });
    controller.forward();
    if(widget.icon == CupertinoIcons.eye_fill) {
      _iconButton = IconButton(
        icon: new Icon(_icon),
        onPressed: () => onPressed(),
      );
     // _isObscure = widget.isObscure;
    }
    else{
      _iconButton = IconButton(
        icon: new Icon(widget.icon),
        onPressed: () => onPressed(),
      );
      _isObscure = widget.isObscure;
    }


    if (widget.isHasNextFocus) {
      return Container(
        width: animation.value,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          //height: MediaQuery.of(context).size.height / 12,
          child: TextFormField(
           // enableInteractiveSelection: true,
            controller: widget.textEditingController,
            obscureText: _isObscure,
            obscuringCharacter: widget.obsCharacter,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            onTap: unFocus,
           /* onChanged:(val) {

              widget.textEditingController.text = val; },*/
            focusNode: focusNode,
            onFieldSubmitted: (_) => focusNode.nextFocus(),

            /*widget.textEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: widget.textEditingController.value.text.length,isDirectional: true)*/

            keyboardType: widget.textInputType,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(

              contentPadding: EdgeInsetsDirectional.only(
                  start: 40,
                top: 30.0,
                  /*end: textFieldContentPaddingHorizontal,
                      top: textFieldContentPaddingVertical,*/
                  /*bottom: textFieldContentPaddingVertical*/),
              labelText: widget.labelText,
               /* labelStyle: TextStyle(
                    color: focusNode.hasFocus ? colorPrimary : Colors.black
                ),*/

              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              hintStyle: TextStyle(fontSize: 14),
              suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(
                    end: textFieldContentPaddingHorizontal),
                child: _iconButton,
              ),
            ),

            validator: (String? value) {
              if (widget.labelText == S.of(context).email) {
                return Validations.validateEmail(value!,context);
              } else {
                return Validations.validateField(value!,context);
              }
            },
          ),
        ),
      );
    } else {
      return Container(
        width: animation.value,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
         // height: MediaQuery.of(context).size.height / 12,
          child: Center(
            child: TextFormField(
              controller: widget.textEditingController,
              obscureText: _isObscure,
              textAlignVertical: TextAlignVertical.center,
              obscuringCharacter: widget.obsCharacter,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
              keyboardType: widget.textInputType,
              /*onChanged:(val) {

                widget.textEditingController.text = val; },*/
              onTap: () => unFocus(),
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsetsDirectional.only(
                    start: 40.0,
                    end: textFieldContentPaddingHorizontal,
                    top: 30.0,
                  /*  bottom: textFieldContentPaddingVertical*/),
                labelText: widget.labelText,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                suffixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(
                      end: textFieldContentPaddingHorizontal),
                  child: _iconButton,
                ),
              ),
              validator: (String? value) {
                if (widget.labelText == S.of(context).email) {
                  return Validations.validateEmail(value!,context);
                } else {
                  return Validations.validateField(value!,context);
                }
              },
            ),
          ),
        ),
      );
    }
  }

  void unFocus() {
    if (!focusNode.hasFocus) {
      //  Fluttertoast.showToast(msg: 'noFocus');
      i = 0;
    } else {
      // Fluttertoast.showToast(msg: 'Focus');
    }

    if (i == 0 && widget.textEditingController!.text.isNotEmpty) {
      widget.textEditingController!.selection = TextSelection(
          baseOffset: 0,
          extentOffset: widget.textEditingController!.value.text.length);
      i = 1;
    } else {
      widget.textEditingController!.selection = TextSelection(
          baseOffset: widget.textEditingController!.value.text.length,
          extentOffset: widget.textEditingController!.value.text.length);
      i = 0;
    }
  }

  onPressed() {

    if (widget.textInputType == TextInputType.visiblePassword) {

      if (_icon == CupertinoIcons.eye_fill) {

        setState(() {
          _icon = CupertinoIcons.eye_slash_fill;
          _isObscure = false;
        });
      } else {
        setState(() {

          _icon = CupertinoIcons.eye_fill;
          _isObscure = true;
        });
      }
    }
  }
  onTextChange(String val , TextEditingController textEditingController)
  {
    textEditingController.text = val;
  }
}
