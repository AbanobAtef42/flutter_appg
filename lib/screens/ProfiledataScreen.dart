import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/icons/my_flutter_app_icons.dart';
import 'package:flutter_app8/models/modelUser.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/styles/textFieldStyle.dart';
import 'package:flutter_app8/styles/textWidgetStyle.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfileData extends StatefulWidget
{

  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   TextEditingController? emailController;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController lNameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();

  bool _visible = false;
  bool internet = true;
  late ProviderUser provider;
  ModelUser? modelUser;

  bool isAlwaysShown = true;

  ScrollController _scrollController = new ScrollController();

  var statusBarHeight;

  bool firstClick = true;
  @override
  void initState() {
    emailController = new TextEditingController();
    _getUserData(context);
    super.initState();
  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
if(statusBarHeight == null)
{
  statusBarHeight = MediaQuery.of(context).padding.top;
}
    return Scaffold(
      /*appBar: AppBar(
        title: Text(home),
      ),*/
      appBar: Styles.getAppBarStyle(context, S.of(context).editProfile, Icons.edit),
      body: RawScrollbar(
        thumbColor: colorPrimary,
        isAlwaysShown: isAlwaysShown,
        controller: _scrollController,
        radius: Radius.circular(8.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: statusBarHeight,
              ),
              getScreenUi(),
            ],
          ),
        ),
      ),
    );

 // return getScreenUi();



  }

  getAppWidget()
  {
    if (modelUser == null) {
      return
        //  MyTextWidgetLabel('loading.....', 'l', Colors.black, textLabelSize);
        Container(
          color: Colors.white,
          child: Center(
              child: CircularProgressIndicator(

              )),
        );
    }
    scrollBarConfig();
   return  Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(

              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 12,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
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

                          ),
                        ),
                        visible: _visible,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RawScrollbar(
                    thumbColor: colorPrimary,
                    radius: Radius.circular(scrollBarRadius),
                    isAlwaysShown: isAlwaysShown,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight:
                                Radius.circular(columnRegisterBorderRadius),
                                topLeft:
                                Radius.circular(columnRegisterBorderRadius)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: textRegisterLabelPadding),
                              child: MyTextWidgetLabel(S.of(context).editProfile, "label",
                                  colorBorder, textLabelSize),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    registerTextFieldLabelDivider),
                            MyTextField(
                                nameController,
                                S.of(context).name,
                                Icons.person,
                                false,
                                " ",
                                true,
                                TextInputType.name
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    textFieldsDivider),
                            MyTextField(
                                lNameController,
                                S.of(context).lName,
                                Icons.person,
                                false,
                                " ",
                                true,
                                TextInputType.name
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    textFieldsDivider),
                            MyTextField(
                                emailController,
                                S.of(context).email,
                                Icons.email,
                                false,
                                " ",
                                true,
                                TextInputType.emailAddress
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    textFieldsDivider),

                            MyTextField(
                                phoneController,
                                S.of(context).phone,
                                Icons.phone_android,
                                false,
                                " ",
                                true,
                                TextInputType.phone
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    textFieldsDivider),
                            MyTextField(
                                addressController,
                                S.of(context).address,
                                Icons.location_on,
                                false,
                                " ",
                                false,
                                TextInputType.streetAddress
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    textFieldButtonDivider),
                            MyButton(
                              onClicked: () => onButtonClick(),
                              child: Text(S.of(context).update),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
  onButtonClick() async
  {
    if(firstClick) {
      setState(() {
        firstClick = false;
      });


      if (await MyApplication.checkConnection())
      {
        _updateProfile(
            nameController.text,
            lNameController.text,
            emailController!.text,
            phoneController.text,
            addressController.text);
      }
      else {
        /*Fluttertoast.showToast(
          msg: 'No Internet Connection',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
        setState(() {
          firstClick = true;
        });
        MyApplication.getDialogue(context, S
            .of(context)
            .noInternet, '', DialogType.ERROR);

      }
    }
  }
  _updateProfile(String name, String lName, String eMail,
      String phone, String address) async {
    Api.context = context;
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
      ProviderUser.name = name;
      ProviderUser.lName = lName;
      ProviderUser.phone = phone;
      ProviderUser.address = address;
      final provider = Provider.of<ProviderUser>(context, listen: false);
      await provider.getPostProfileData(context);
      setState(() {
        _visible = false;
        firstClick = true;
      });

      if (provider.modelUserProfile != null && provider.modelUserProfile!.message == 'تم تحديث الملف الشخصي بنجاح') {
        /*Fluttertoast.showToast(
            msg: S.of(context).profileUpdated,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: colorPrimary,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM);*/
        MyApplication.getDialogue(context, S.of(context).profileUpdated, '', DialogType.SUCCES);




      }
    } else {
      final snackBar = SnackBar(content: Text(S.of(context).fillIn));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  getScreenUi() {

    if (!internet) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    Icons.wifi_off_rounded,
                    color: colorPrimary,
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                    fit: BoxFit.contain, child: Text(S.of(context).noInternet,style: TextStyle(color: Theme.of(context).textTheme.headline1!.color),))),
          ],
        ),
      );
    } else if ((modelUser != null) && ( modelUser!.message == 'slint' ) ) {
      /* Fluttertoast.showToast(
          msg: S.of(context).slowInternet,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    MyFlutterApp.slow_internet,
                    color: colorPrimary,
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                    fit: BoxFit.contain, child: Text(S.of(context).slowInternet,style: TextStyle(color: Theme.of(context).textTheme.headline1!.color)),)),
          ],
        ),
      );
    }

    return getAppWidget();
  }
  _getUserData(BuildContext context) async {
    provider = Provider.of<ProviderUser>(context, listen: false);


    //  return;

    if (!await MyApplication.checkConnection()) {
      await Provider.of<ProviderUser>(context, listen: false).getUserData(context);
      setState(() {
        modelUser = provider.modelUser;
        internet = false;
        if(modelUser != null) {
          populateUi(modelUser!);
        }

      });
    } else {
      await Provider.of<ProviderUser>(context, listen: false).getUserData(context);
      setState(() {
        modelUser = provider.modelUser;
        if(modelUser != null) {
          populateUi(modelUser!);
        }
      });
    }
  }
  populateUi(ModelUser? modelUser)
  {
    if(modelUser != null) {
      nameController.text = modelUser.user!.firstName!;
      lNameController.text = modelUser.user!.lastName!;
      emailController!.text = modelUser.user!.email!;
      phoneController.text = modelUser.user!.phone!;
      addressController.text = modelUser.user!.address!;
    }
  }
  scrollBarConfig() {
    if (isAlwaysShown) {
      Timer.periodic(Duration(milliseconds: 2100), (timer) {
        if (this.mounted) {
          setState(() {
            isAlwaysShown = false;
          });
        }
      });
    }
  }
}