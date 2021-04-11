import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/screens/loginScreen.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';

class StartShopping extends StatefulWidget
{
  static var name = 'startShopping';

  @override
  _StartShoppingState createState() => _StartShoppingState();
}

class _StartShoppingState extends State<StartShopping> {
  int _current = 0;
  final List<String> imgList = [
         'images/ads1.jpg',
         'images/ads2.jpg',
         'images/ads3.jpg',
         'images/ads44.jpg',
         'images/ads5.jpg',
         'images/ads6.jpg'
  ];

  double? statusBarHeight;
  @override
  void initState() {

    super.initState();
  }
  @override
  dispose() {

    //
    super.dispose();

    // Exit full screen
  }
  @override
  void didChangeDependencies() {
    statusBarHeight = 20.0;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
   return getAppWidget();
  }
 Widget getAppWidget()
  {
   return SafeArea(
     child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          SizedBox(height: statusBarHeight!*2,),

          SizedBox(
               width: MediaQuery.of(context).size.width / 3,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(S.of(context).swiToBrw,style: Theme.of(context).textTheme.headline2,))),
          SizedBox(height: statusBarHeight,),
          Text(S.of(context).stShopDesc,style: Theme.of(context).textTheme.headline3,textAlign: TextAlign.center,),
          SizedBox(height: statusBarHeight,),
          CarouselSlider(
          options: CarouselOptions(
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 2),
              enlargeCenterPage: true,
              height: MediaQuery.of(context).size.height / 2  ,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              viewportFraction: 0.75),
          items: imgList
              .map((item) => Stack(
            children: [
              new Align(
                alignment: Alignment.center,
                child: /*Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width / 1,
                  height:
                  MediaQuery.of(context).size.height / 3,
                ),*/
                
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Image.asset(item,fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width / 1,
                    height:
                    MediaQuery.of(context).size.height / 2.5,),
                )
              ),
              
            ],
          )
          )
              .toList(),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: _current== index? 16.0:8.0,
                height: _current== index? 16.0:8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? colorPrimary
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: statusBarHeight,),
          MyButton(
            onClicked: () => onButtonClick(),
            child: Text(S.of(context).stShopping),
          ),
      ])
     ),
   );
  }

  onButtonClick() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),);
  }
}