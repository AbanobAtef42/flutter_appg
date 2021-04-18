import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/clippers/OctagonClipper.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/models/ModelOrders.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';


class CustomerOrdersDetail extends StatefulWidget {
  final Datum modelOrders;
  CustomerOrdersDetail(this.modelOrders);
  @override
  _CustomerOrdersDetailState createState() => _CustomerOrdersDetailState();
}

class _CustomerOrdersDetailState extends State<CustomerOrdersDetail> {
  bool isAlwaysShown = false;
  double? height;
  double? width;
  double? paddingStart;
  double? paddingVertical;
  final iconColor = Colors.white;
  double? statusBarHeight;

  double? photoWiHei;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if(statusBarHeight == null)
    statusBarHeight = MediaQuery.of(context).padding.top;
    if(height == null)
    height = MediaQuery.of(context).size.height;
    if(width == null)
    width = MediaQuery.of(context).size.width;
    if(paddingStart == null)
    paddingStart = width!/8;
    if(paddingVertical == null)
      paddingVertical = 12.0;
    if(photoWiHei == null)
    orderPhotoWidHei();
    return Scaffold(
      /*appBar: AppBar(
                title: Text(cats,
              ),*/
      resizeToAvoidBottomInset: false,
      appBar: Styles.getAppBarStyle(context, S.of(context).orderDetails, Icons.details),
      body: RawScrollbar(
        thumbColor: colorPrimary,
        isAlwaysShown: isAlwaysShown,
        // controller: _scrollController,
        radius: Radius.circular(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 0,
              ),
              getAppWidget(),
            ],
          ),
        ),
      ),
    );
  }

  getAppWidget() {
    return Column(children: [
      Padding(
        padding:  EdgeInsets.only(top: 12.0,bottom: 12.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: paddingStart,
          ),
          ClipOval(
            child: Container(
                width: photoWiHei,
                height: photoWiHei,
                child: Image.asset('images/user.png',fit: BoxFit.fitWidth,)),
          ),
          Padding(
            padding:  EdgeInsetsDirectional.only(start: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width!/2.1,
                  child: Text(
                    widget.modelOrders.name!,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                SizedBox(
                  height: paddingVertical,
                ),
                Container(
                  width: width!/2.1,
                  child: Text(
                    widget.modelOrders.address!,
                    style: Styles.getTextGreyStyle(context),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: paddingVertical,
                ),
                Container(
                  width: width!/2.1,
                  child: Text(
                    S.of(context).phone + ' : ' + widget.modelOrders.customerId!.phone!,
                    style: Styles.getTextGreyStyle(context),
                  ),
                ),
              ],

            ),
          ),
        ],
    ),
      ),
    Divider(),
    orderDataRowWidget(Icons.date_range/*FlutterIcons.date_range_mdi*/, S.of(context).orderedAt, widget.modelOrders.createdAt.toString()),

    Divider(),
    orderDataRowWidget(FontAwesome5.box_open/*FlutterIcons.box_open_faw5s*/, S.of(context).item, widget.modelOrders.items![0].productId!.name!),

    Divider(),
    orderDataRowWidget(Linecons.money/*FlutterIcons.attach_money_mdi*/, S.of(context).amount, widget.modelOrders.total.toString() + ' '+ sharedPrefs.priceUnitKey),



    ]);


  }

  Widget orderDataTypePhotoWidget(IconData icon) {
    return ClipPath(
      clipper: OctagonClipPathClass(),

        child: Container(
          width: photoWiHei,
          height: photoWiHei,
          color: colorPrimary,
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),

    );
  }

  orderPhotoWidHei() {
    if (width! > height!) {
      photoWiHei = height!/10;
    } else {
      photoWiHei = width!/8;
    }
  }

  orderDataRowWidget(IconData icon, String title, String value) {
   return Padding(
     padding:  EdgeInsets.only(top: 12.0,bottom: 12.0),
     child: Row(
crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [

        SizedBox(
          width: paddingStart,
        ),
        orderDataTypePhotoWidget(icon),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16.0),
          child: Container(
              width: width!/4.6,

              child: Text(

                title,
                textHeightBehavior: TextHeightBehavior.fromEncoded(2),

                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline3,
              )),
        ),
        Container(
          width: width!/2.5,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: Text(
              value,
              style: Styles.getTextGreyStyle(context),
            ),
          ),
        ),
      ]),
   );
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
