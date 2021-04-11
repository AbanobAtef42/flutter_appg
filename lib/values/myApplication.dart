import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:path_provider/path_provider.dart';

import 'api.dart';

class MyApplication {
  static late AwesomeDialog awesomeDialogue;

  static showAlertDialog(
      BuildContext context, String title, String subtitle, String action) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(action),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      backgroundColor: colorPrimary,
      titleTextStyle: Styles.getTextDialogueStyle(),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<bool> checkConnection() async {
    var connectivityResult;
    if (connectivityResult == null) {
      connectivityResult = await (Connectivity().checkConnectivity());
    }

    {
      return connectivityResult == ConnectivityResult.none ? false : true;
    }
  }
  static getDialogue(BuildContext context , String title , String subtitle , DialogType dialogType)
  {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType:dialogType ,
      dismissOnTouchOutside: true,
      showCloseIcon: true,
      headerAnimationLoop: false ,
      btnOk: Padding(
        padding: const EdgeInsets.only(right: 32.0 , left: 32.0),
        child: MyButton(
            child: Text(S.of(context).ok),
            onClicked: () {
              Navigator.pop(context);

            }),
      ),
     // closeIcon: IconButton(icon: Icon(Icons.close,color: Colors.white,size: 10.0,),),
      btnOkColor: colorPrimary,
      /*body: Center(child: Text(
        'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),),*/
      title: title,
      desc:   subtitle,

      btnOkOnPress: () {},
    )
    ..show();


  }
  static getDialogue2(BuildContext context , String title , String? subtitle , DialogType dialogType)
  {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType:dialogType ,
      dismissOnTouchOutside: true,
      showCloseIcon: true,


      // closeIcon: IconButton(icon: Icon(Icons.close,color: Colors.white,size: 10.0,),),
      btnOkColor: colorPrimary,
      /*body: Center(child: Text(
        'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),),*/
      title: title,
      desc:   subtitle,
      onDissmissCallback: ()=> Navigator.of(context, rootNavigator: true).pop('dialog'),
      btnOkOnPress: () {},
    )
      ..show();


  }
  static dismiss()
  {
    awesomeDialogue.dissmiss();
  }
  static initCache() {
    if (!kIsWeb) {
      getApplicationDocumentsDirectory().then((dir) {
        Api.cacheStore =
            DbCacheStore(databasePath: dir.path, logStatements: true);
      });
    } else {
      Api.cacheStore = DbCacheStore(databasePath: 'db', logStatements: true);
    }
  }
}
