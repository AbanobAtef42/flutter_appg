import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app8/bottom_nav_routes/Account.dart';
import 'package:flutter_app8/bottom_nav_routes/Cart.dart';
import 'package:flutter_app8/bottom_nav_routes/Categories.dart';
import 'package:flutter_app8/bottom_nav_routes/Home.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:flutter_app8/bottom_nav_routes/Account.dart';
import 'package:flutter_app8/bottom_nav_routes/Cart.dart';
import 'package:flutter_app8/bottom_nav_routes/Categories.dart';
import 'package:flutter_app8/bottom_nav_routes/Home.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';

import 'dart:ui' as ui;
import 'package:intl/intl.dart' as intl;

class BottomNavHost extends StatefulWidget {
  static String name = 'BottomNavHost';
  @override
  _BottomNavHostState createState() => _BottomNavHostState();
}

class _BottomNavHostState extends State<BottomNavHost> {
  int _selectedIndex = 0;

  var _textDirection;

  late AwesomeDialog awesomeDialog;
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Categories(''),
    Account(),
    Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    if (_textDirection == null) {
      _textDirection =
          intl.Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode)
              ? TextDirection.rtl
              : TextDirection.ltr;
    }
    getDialogue(context);
    return WillPopScope(
      onWillPop: () async {
        awesomeDialog.show();
        return false;
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.list),
              label: S.of(context).cats,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined),
              label: S.of(context).account,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: S.of(context).cart,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: colorPrimary,
          unselectedItemColor: colorBorder,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  getDialogue(BuildContext context) {
    awesomeDialog = AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.QUESTION,
          headerAnimationLoop: false,
          isDense: false,
          dismissOnTouchOutside: false,
          btnOk: MyButton(
              child: Text(S.of(context).yes),
              onClicked: () {
                Navigator.pop(context);
                SystemNavigator.pop();
              }),
          // showCloseIcon: true,

          title: S.of(context).exit,
          desc: '',
          btnCancel: MyButton(
            child: Text(S.of(context).no),
            onClicked: () => Navigator.pop(context),
          ),
        )  ;
  }
}
