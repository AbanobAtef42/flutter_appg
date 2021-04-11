import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/models/ModelProducts.dart';
import 'package:flutter_app8/models/ModelsGoverns.dart';
import 'package:flutter_app8/models/modelUser.dart';
import 'package:flutter_app8/providers/providerHome.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/styles/textFieldStyle.dart';
import 'package:flutter_app8/styles/textWidgetStyle.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  static String name = 'CheckOut';
  final Datum? modelProducts;
  final int qnt;
  final List<String?> options;


  CheckOut(this.modelProducts, this.options,this.qnt);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController lNameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  GlobalKey govKey = GlobalKey();
  GlobalKey cityKey = GlobalKey();
  GlobalKey shipKey = GlobalKey();
  bool _visible = false;
  bool internet = true;
  late ProviderUser provider;
  Gov? gov;
  City? city;
  Shipping? shipping;
  late List shippers;
  double? divideBy;
  double borderRadius = 30.0;
  final dynamic width = null;
  double? dropPadding;
  var country1;
  var city1;

  var shipper1;
  var _signingCharacter;
  double radioTextSize = 14.0;
  var counter = 1;
  var _textDirection;

  ModelUser? modelUser;
  ModelGoverns? modelGoverns;

  double? statusBarHeight;

  var price;

  bool isAlwaysShown = true;

  late AlertDialog alert;

  @override
  void initState() {
    _getUserData(context);
    _getGovsData(context);

    // _textDirection = intl.Bidi.isRtlLanguage( Localizations.localeOf(context).languageCode) ? TextDirection.rtl : TextDirection.ltr;
    super.initState();
    shippers = ['BARQ', 'GREEN', 'QUICK'];
  }

  @override
  Widget build(BuildContext context) {
    if (divideBy == null) {
      divideBy = 1.1;
    }
    if (_signingCharacter == null) {
      _signingCharacter = S.of(context).cash;
    }
    if (statusBarHeight == null) {
      statusBarHeight = MediaQuery.of(context).padding.top;
    }

    if (dropPadding == null) {
      dropPadding = MediaQuery.of(context).size.width / 20;
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  height: 0,
                ),
                getScreenUi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAppWidget(BuildContext context) {
    // S.load(Locale('en','');
    final dropPadding = MediaQuery.of(context).size.width / 13;
    final dropPaddingver =
        MediaQuery.of(context).size.height / textFieldsDivider;

    //appBar: AppBar(title: Text(widget.title)),
    if (modelUser == null || modelGoverns == null) {
      return
          //  MyTextWidgetLabel('loading.....', 'l', Colors.black, textLabelSize);
          Container(
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(

          ),
        ]),
      );
    }
    scrollBarConfig();
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height:
                      MediaQuery.of(context).size.height / dropPadding * 1 / 2
                  //child: MyTextWidgetLabel(perData,'label',Colors.black,Theme.of(context).textTheme.headline3.fontSize),
                  ),
              // SizedBox(height: dropPaddingver),
              RawScrollbar(
                thumbColor: colorPrimary,
                isAlwaysShown: isAlwaysShown,
                radius: Radius.circular(scrollBarRadius),
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
                          padding: const EdgeInsets.only(top: 0),
                          child: MyTextWidgetLabel(S.of(context).perData,
                              "label", colorBorder, textLabelSize),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                registerTextFieldLabelDivider /
                                2),
                        MyTextField(nameController, S.of(context).name,
                            Icons.person, false, " ", true, TextInputType.name),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                textFieldsDivider),
                        MyTextField(lNameController, S.of(context).lName,
                            Icons.person, false, " ", true, TextInputType.name),
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
                            TextInputType.emailAddress),
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
                            TextInputType.phone),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                textFieldsDivider),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width / divideBy! ,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorBorder),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)),
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: dropPadding, end: dropPadding),
                                child: DropdownButton<String>(
                                  underline: Text(''),
                                  isExpanded: true,
                                  hint: Text(
                                    'مصر',
                                  ),
                                  icon: Icon(Icons.location_on),
                                  value: country1,
                                  onChanged: (String? value) {
                                    if(this.mounted) {
                                      setState(() {
                                        country1 = value;
                                      });
                                    }
                                  },
                                  items: [],
                                  /* items: widget.modelProducts.vars[index].value
                                    .map((value) => DropdownMenuItem<String>(
                                  value: value.label,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        value.label,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ))
                                    .toList(),
                              ),*/
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                textFieldsDivider),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width / divideBy!,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorBorder),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: dropPadding, end: dropPadding),
                                  child: DropdownButton<Gov>(
                                    key: govKey,
                                    isExpanded: true,
                                    icon: Row(
                                      children: [
                                        Icon(Icons.arrow_drop_down_outlined)
                                      ],
                                    ),
                                    underline: Text(''),
                                    hint: Text(S.of(context).governorate),
                                    // icon:Icon(Icons.location_on) ,
                                    value: gov,
                                    onChanged: (Gov? value) {
                                      if(this.mounted) {
                                        setState(() {
                                          gov = value;

                                          city = null;
                                        });
                                      }
                                    },
                                    items: modelGoverns!.govs!
                                        .map((value) => DropdownMenuItem<Gov>(
                                              value: value,
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    value.name!,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                textFieldsDivider),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width / divideBy!,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorBorder),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: dropPadding, end: dropPadding),
                                  child: DropdownButton<City>(
                                    isExpanded: true,
key: cityKey,
                                    underline: Text(''),
                                    hint: Text(S.of(context).city),
                                    //  icon:Icon(Icons.location_on) ,
                                    value: city,
                                    onChanged: (City? value) {
                                      if(this.mounted) {
                                        setState(() {
                                          city = value;
                                        });
                                      }
                                    },
                                    items: gov != null
                                        ? gov!.cities!
                                            .map((value) =>
                                                DropdownMenuItem<City>(
                                                  value: value,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        value.name!,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList()
                                        : [],
                                    /* items: widget.modelProducts.vars[index].value
                                      .map((value) => DropdownMenuItem<String>(
                                    value: value.label,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          value.label,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                ))
                                      .toList(),
                              ),*/
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                textFieldsDivider),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width / divideBy!,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorBorder),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: dropPadding, end: dropPadding),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: Text(''),
                                    key: shipKey,
                                    hint: Text(S.of(context).shipper),
                                    //   icon:Icon(Icons.location_on) ,
                                    value: shipper1,
                                    onChanged: (value) {
                                      switch (value) {
                                        case 'BARQ':
                                          price = gov!.shipping!.barq;
                                          break;
                                        case 'GREEN':
                                          price = gov!.shipping!.green;
                                          break;
                                        case 'QUICK':
                                          price = gov!.shipping!.quick;
                                          break;
                                      }
                                      if(this.mounted) {
                                        setState(() {
                                          shipper1 = value;
                                          print(
                                              'fdfdfdfdfdfdf' +
                                                  price.toString());
                                        });
                                      }
                                    },
                                    items: gov != null
                                        ? shippers
                                            .map((value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        value,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList()
                                        : [],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            TextInputType.streetAddress),

                        /* Padding(
                            padding: const EdgeInsets.only(
                                top: textRegisterLabelPadding),
                            child: MyTextWidgetLabel(quantity, "label",
                                colorBorder, textLabelSize),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  textFieldButtonDivider),
                          quantityWidget(),*/

                        Padding(
                          padding: const EdgeInsets.only(
                              top: textRegisterLabelPadding),
                          child: MyTextWidgetLabel(S.of(context).payment,
                              "label", colorBorder, textLabelSize),
                        ),
                        radioWidget(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                textFieldsDivider /
                                4),
                        MyButton(
                          onClicked: () => onButtonClick(),
                          child: Text(S.of(context).checkOut),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 20),
                      ],
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

  void onButtonClick() async {
    if (await MyApplication.checkConnection()) {
      Api.context = context;
      _sendOrder();
    } else {
      /*Fluttertoast.showToast(
          msg: S.of(context).noInternet,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
      MyApplication.getDialogue(
          context, S.of(context).noInternet, '', DialogType.ERROR);
    }
  }

  _sendOrder() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
//Api.context = context;
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    final FormState form = _formKey.currentState!;
    if (form.validate()  && gov != null && city != null && price != null ) {
    //  MyApplication.getDialogue(context, 'processing', 'Please Wait', DialogType.INFO);
      showLoaderDialog(context);
      List<String?> vars = [];

      for (int i = 0; i < widget.options.length ; i++) {
        vars.add(widget.options[i]);
        if (i == 0) {
          //vars += json.encode( widget.options[i]).toString().replaceAll("\'", '') + ',';
        } else {
         // vars +=  json.encode( widget.options[i]).toString().replaceAll("\'", '');
        }
      }
      Map<String, Object> options = {
        "cart": [
          {
            "product_id": widget.modelProducts!.id,
            "qnt":widget.qnt,
            "price": widget.modelProducts!.price,
            "discount": widget.modelProducts!.discount,
            "options": vars
          }
        ],
      };
      Map<String, Object> cartWithOutOptions = {
        "cart": [
          {
            "product_id": widget.modelProducts!.id,
            "qnt": widget.qnt,
            "price": widget.modelProducts!.price.toString(),
            "discount": widget.modelProducts!.discount.toString(),
          }
        ],
      };
      final provider = Provider.of<ProviderHome>(context, listen: false);
      double total = double.parse(widget.modelProducts!.price!) +
          double.parse(price.toString());
      final Map<String, Object?> data = {
        "first_name": nameController.text.toString(),
        "last_name": lNameController.text.toString(),
        "phone": phoneController.text.toString(),
        "email": emailController.text.toString(),
        "address": addressController.text.toString(),
        "gov_id": gov!.id,
        "city_id": city!.id,
        "payment": "cash",
        "shipped": price,
        "total":( widget.modelProducts!.discount !=  null && widget.modelProducts!.discount.toString() != "0" ) ? total -
            double.parse(widget.modelProducts!.discount!) : total
      };
      if (vars.length == 0) {
        data.addAll(cartWithOutOptions);
      } else {
        data.addAll(options);
      }
     // Navigator.pop(context);
      await provider.sendOrder(data);

     // Navigator.of(context, rootNavigator: true).pop(alert);
    //  if(provider.sentOrder != null)
     // Navigator.pop(context);
      // if (!provider.loading) {
      //MyApplication.dismiss();
      /*if(this.mounted) {
        setState(() {
          // MyApplication.dismiss();
        });*/
     // }

      // MyApplication.showAlertDialog(context, signed, '', '');

    } else {
      if(gov == null)
      {
        openDropdown(govKey);
      }
      else if(city == null)
      {
        openDropdown(cityKey);
      }
      else if(price == null)
      {
        openDropdown(shipKey);
      }

      final snackBar = SnackBar(content: Text(S.of(context).fillIn));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
  }

  quantityWidget() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: textRegisterLabelPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: colorPrimary,
              splashColor: Colors.grey,
              onPressed: () => onPressAdd()),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Text(counter.toString()),
            ),
          ),
          FloatingActionButton(
              child: Icon(
                CupertinoIcons.minus,
                color: Colors.white,
              ),
              backgroundColor: colorPrimary,
              splashColor: Colors.grey,
              onPressed: () => onPressMinus()),
        ],
      ),
    );
  }

  onPressAdd() {
    if(this.mounted) {
      setState(() {
        counter++;
      });
    }
  }

  onPressMinus() {
    if (counter != 1) {
      if(this.mounted) {
        setState(() {
          counter--;
        });
      }
    }
  }

  radioWidget() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              S.of(context).cash,
              style: TextStyle(fontSize: radioTextSize),
            ),
            leading: Radio(
              value: S.of(context).cash,
              autofocus: true,
              focusColor: colorPrimary,
              fillColor: MaterialStateProperty.all(colorPrimary),
              groupValue: _signingCharacter,
              onChanged: (dynamic value) {
    if(this.mounted) {
      setState(() {
        _signingCharacter = value;
      });
    }
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              S.of(context).online,
              style: TextStyle(fontSize: radioTextSize),
            ),
            leading: Radio(
              value: S.of(context).online,
              focusColor: colorPrimary,
              fillColor: MaterialStateProperty.all(colorPrimary),
              groupValue: _signingCharacter,
              onChanged: (dynamic value) {
    if(this.mounted) {
      setState(() {
        _signingCharacter = value;
      });
    }
              },
            ),
          ),
        ),
      ],
    );
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
                    fit: BoxFit.contain,
                    child: Text(
                      S.of(context).noInternet,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color),
                    ))),
          ],
        ),
      );
    } else if ((modelUser != null && modelGoverns != null) &&
        (modelUser!.message == 'slint' || modelGoverns!.name == 'slint')) {
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
                    Icons.wifi_off_rounded,
                    color: colorPrimary,
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(S.of(context).slowInternet,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color)),
                )),
          ],
        ),
      );
    }

    return getAppWidget(context);
  }

  _getUserData(BuildContext context) async {
    provider = Provider.of<ProviderUser>(context, listen: false);

    //  return;

    if (!await MyApplication.checkConnection()) {
      Api.context = context;
      // await Provider.of<ProviderUser>(context, listen: false).getUserData(context);
      if(this.mounted) {
        setState(() {
          //  modelUser = provider.modelUser;
          internet = false;
          if (modelUser != null) {
            populateUi(modelUser!);
          }
        });
      }
    } else {
      await Provider.of<ProviderUser>(context, listen: false)
          .getUserData(context);
      if(this.mounted) {
        setState(() {
          modelUser = provider.modelUser;
          if (modelUser != null) {
            populateUi(modelUser!);
          }
        });
      }
    }
  }

  _getGovsData(BuildContext context) async {
    provider = Provider.of<ProviderUser>(context, listen: false);

    //  return;

    if (!await MyApplication.checkConnection()) {
      Api.context = context;
      //await Provider.of<ProviderUser>(context, listen: false).getGovsData(context);
      if(this.mounted) {
        setState(() {
          // modelGoverns = provider.modelGoverns;
          internet = false;
        });
      }
    } else {
      await Provider.of<ProviderUser>(context, listen: false)
          .getGovsData(context);
      if(this.mounted) {
        setState(() {
          modelGoverns = provider.modelGoverns;
        });
      }
    }
  }

  populateUi(ModelUser modelUser) {
    if (modelUser.user != null) {
      nameController.text = modelUser.user!.firstName!;
      lNameController.text = modelUser.user!.lastName!;
      emailController.text = modelUser.user!.email!;
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
  void openDropdown(GlobalKey globalKey) {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext? element) {
      element!.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector?;
          //return false;

        } else {
          searchForGestureDetector(element);
        }

       // return true;
      });
    }

    searchForGestureDetector(globalKey.currentContext!);

    assert(detector != null);

    detector!.onTap!();
  }
  showLoaderDialog(BuildContext context){
     alert=AlertDialog(
       backgroundColor: colorPrimary,
      content: new Row(
        children: [
          CircularProgressIndicator(backgroundColor: colorPrimary,),
          SizedBox(width: 13,),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Sending Order..." ,style: TextStyle(color: Colors.white),)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );

  }
}
