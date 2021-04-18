import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/main.dart';
import 'package:flutter_app8/models/modelUser.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/screens/BottomNavScreen.dart';
import 'package:flutter_app8/screens/RegisterScreen.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/styles/textFieldStyle.dart';
import 'package:flutter_app8/styles/textWidgetStyle.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart' as intl;

class LoginScreen extends StatefulWidget {
  static var name = 'login';

  LoginScreen({this.title});
  final String? title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Icon _passIcon = new Icon(CupertinoIcons.eye_fill);
 // SharedPreferences sharedPreferences =  SharedPreferences.getInstance() as SharedPreferences;
  bool _visible = false;
//Box<User> boxUser;
  var _textDirection;
  @override
  void dispose() {
   // MyApplication.dismiss();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
   // boxUser = Hive.box(dataBoxNameUser);
    if(sharedPrefs.mailKey != null && sharedPrefs.passKey != null)
    {
      emailController.text = sharedPrefs.mailKey;
      passController.text = sharedPrefs.passKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var focusNode = FocusNode();

    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
           automaticallyImplyLeading: false,
           title: Text(''),
           toolbarHeight: MediaQuery.of(context).size.height/8,

           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(
             bottom: new Radius.elliptical(
                 MediaQuery.of(context).size.width, 150.0)),
           ),
         ),


        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:[
                      /*ClipPath(
                        clipper: OvalBottomBorderClipper(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 11,
                          color: Colors.deepPurple,

                        ),
                      ),*/
                      Container(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    registerTopViewHeight,
                                width: MediaQuery.of(context).size.height /
                                    registerTopViewHeight,
                                child: CircularProgressIndicator(
                                 // color: colorPrimary,

                                ),
                              ),
                              visible: _visible,
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          MyTextWidgetLabel(
                              S.of(context).loginLabel, "label", colorBorder, textLabelSize),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  loginTextFieldLabelDivider),
                          MyTextField(
                            emailController,
                              S.of(context).email,
                            Icons.person,
                            false,
                            " ",
                            true,
                              TextInputType.emailAddress
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  textFieldsDivider),
                          MyTextField(
                            passController,
                            S.of(context).password,
                            CupertinoIcons.eye_fill,
                            true,
                            "*",
                            false,
                              TextInputType.visiblePassword
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  textFieldButtonDividerLogin),
                          MyButton(
                            onClicked: () => onButtonClick(),
                            child: Text(S.of(context).login),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  textFieldButtonDividerLogin /
                                  2),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: InkWell(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyTextWidgetLabel(S.of(context).notRegistered, 'l',
                                      colorPrimary, textLabelSize),
                                  MyTextWidgetLabel(
                                      S.of(context).signupnow, 'l', colorBorder, textLabelSize),
                                ],
                              ),
                              onTap: goToRegister,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 4),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  _login(String eMail, String password) async {
if(kIsWeb && !await MyApplication.checkConnection())
{
  MyApplication.getDialogue(context,S.of(context).loginFailed, S.of(context).noInternet, DialogType.ERROR);
}
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        _visible = true;
      });
      ProviderUser.eMail = eMail;
      ProviderUser.password = password;
      final provider = Provider.of<ProviderUser>(context, listen: false);
       await provider.getPostLoginData(context);
      // if (!provider.loading) {
      setState(() {
        _visible = false;
      });

      if (provider.modelUser!.message == 'success') {
        String token = provider.modelUser!.token!;
        String email = provider.modelUser!.user!.email!;
        String pass = passController.text;
        String name = provider.modelUser!.user!.fullName!;
        String currentId = provider.modelUser!.user!.id.toString();

         SharedPrefs().token(token);
         SharedPrefs().eMail(email);
         SharedPrefs().pass(pass);
         SharedPrefs().name(name);
         SharedPrefs().currentUserId(currentId);
       //  boxUser.put(SharedPrefs().getCurrentUserId,provider.modelUser.user);
        Fluttertoast.showToast(
            msg: S.of(context).signed,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: colorPrimary,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            fontSize: textLabelSize);
      //  MyApplication.getDialogue(context, S.of(context).signed, '', DialogType.SUCCES);
        User? user = provider.modelUser!.user;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavHost('')));
        // MyApplication.showAlertDialog(context, signed, '', '');
      }
    } else {
      final snackBar = SnackBar(content: Text(S.of(context).fillIn));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RegisterScreen(
                title: S.of(context).register,
              )),
    );
  }

  void onButtonClick() async {
    if (await MyApplication.checkConnection()) {
      Api.context = context;
      _login(emailController.text, passController.text);
    } else {
      /*Fluttertoast.showToast(
          msg: S.of(context).noInternet,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
      MyApplication.getDialogue(context,S.of(context).loginFailed, S.of(context).noInternet, DialogType.ERROR);
    }
  }
}
