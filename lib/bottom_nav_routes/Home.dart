import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app8/bottom_nav_routes/Categories.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/models/ModelAds.dart';
import 'package:flutter_app8/models/ModelCats.dart';
import 'package:flutter_app8/models/ModelProducts.dart';
import 'package:flutter_app8/models/ModelSetting.dart';
import 'package:flutter_app8/providers/providerHome.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/screens/ProductDetailScreen.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/styles/textWidgetStyle.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/linecons_icons.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  static var name = 'home';

  /*static ModelAds modelAds;
  static double statusBarHeight;
  static ModelCats modelCats;

  static ModelProducts modelProducts;*/

  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  ModelAds? modelAds;
  double? statusBarHeight;
  ModelCats? modelCats;
  double? listPadding;
  ModelProducts? modelProducts;
  ScrollController _scrollController = new ScrollController();
  late var provider;
  late var provider2;
  bool adsSlow = false;
  bool catsSlow = false;
  bool prosSlow = false;
  bool internet = true;
  bool isAlwaysShown = true;

  ModelSetting? modelSettings;

  @override
  void initState() {
    _getPriceUnit(context, 'admin.\$');
    super.initState();

    initCache();
    //_scrollController.addListener(() {

   // });
  }
@override
  void dispose() {

    super.dispose();
  }
  @override
  void didChangeDependencies()  {

    _getAds(context);
    _getCats(context);
    _getProducts(context);


    statusBarHeight = MediaQuery.of(context).padding.top;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (listPadding == null) {
      listPadding = MediaQuery.of(context).size.width / 25;
    }

    return Scaffold(
      /*appBar: AppBar(
        title: Text(home),
      ),*/
appBar: AppBar(toolbarHeight: 0.0,),
      body: RawScrollbar(
        thumbColor: colorPrimary,
        isAlwaysShown: isAlwaysShown,
        controller: _scrollController,
        radius: Radius.circular(8.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
               // height: statusBarHeight,
              ),
              getScreenUi(),
            ],
          ),
        ),
      ),
    );
  }

  _getAds(BuildContext context) async {
    provider = Provider.of<ProviderHome>(context, listen: false);


      //  return;

    if (!await MyApplication.checkConnection()) {
      await Provider.of<ProviderHome>(context, listen: false).getAds();
      if (this.mounted) {
        setState(() {
                modelAds = provider.modelAds;
                internet = false;
              });
      }
    } else {
      await Provider.of<ProviderHome>(context, listen: false).getAds();
      if (this.mounted) {
        setState(() {
                modelAds = provider.modelAds;
              });
      }
    }
  }

  _getCats(BuildContext context) async {
    provider = Provider.of<ProviderHome>(context, listen: false);
    await Provider.of<ProviderHome>(context, listen: false).getCats();
    if (this.mounted) {
      setState(() {
            modelCats = provider.modelCats;
          });
    }
  }

  _getProducts(BuildContext context) async {
    provider = Provider.of<ProviderHome>(context, listen: false);

    await Provider.of<ProviderHome>(context, listen: false)
        .getProducts('', '', '1');
    if (this.mounted) {
      setState(() {
            modelProducts = provider.modelProducts;
          });
    }
  }

  Widget getAppWidget(BuildContext context) {
    if (modelAds == null || modelCats == null || modelProducts == null || modelSettings == null) {
      hideScrollBar();
      return
          //  MyTextWidgetLabel('loading.....', 'l', Colors.black, textLabelSize);

        Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                CircularProgressIndicator(

                ),
              ]),
        );
    } else {
      scrollBarConfig();
      List urls = fetchUrls(modelAds!);
      List cats = modelCats!.data!;
      List products = modelProducts!.data!;
      final List<String> imgList = [
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
        // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
        // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
      ];
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height / 3.9,
                      autoPlayInterval: Duration(seconds: 2),
                      onPageChanged: (index, reason) {
                        if (this.mounted) {
                          setState(() {
                                                    _current = index;
                                                  });
                        }
                      },
                      viewportFraction: 0.8),
                  items: imgList
                      .map((item) => Stack(
                            children: [
                              new Align(
                                alignment: Alignment.topCenter,
                                child: CachedNetworkImage(
                                    imageUrl:item,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width / 1,
                                  height: MediaQuery.of(context).size.height / 4,
                                ),
                              ),
                              new Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          color: colorSemiWhite2,
                                          child: Text(
                                            modelAds!
                                                .data![
                                                    0 /*imgList.indexOf(item)*/]
                                                .title!,
                                            style: Styles.getTextAdsStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ), //urls.indexOf(item)
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          color: colorSemiWhite2,
                                          child: Text(
                                            modelAds!
                                                .data![
                                                    0 /*imgList.indexOf(item)*/]
                                                .description!,
                                            style: Styles.getTextAdsStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      MyButton(
                                        onClicked:null /*(){ _launchURL('https://foryou.flk.sa/store/' + modelAds!.data![0].title!);}*/,
                                        child: Text(
                                          modelAds!
                                              .data![0 /*imgList.indexOf(item)*/]
                                              .button!,
                                          style: Styles.getTextDialogueStyle(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),

                /*Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.map((url) {
                        int index = imgList.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),*/
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: _current == index ? 16.0 : 8.0,
                  height: _current == index ? 16.0 : 8.0,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount: cats.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap:()=> Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>Categories(cats[index].slug))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                     placeholder:(context,s)=> Icon(Icons.camera),imageUrl:imgList[0],
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width / 4,
                                          height: MediaQuery.of(context).size.width / 4,
                                        ),
                                      ),
                                      radius: 30,
                                    ),
                                   // SizedBox(height: 10,),
                                    Text(cats[index].name),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 16/9,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                  child: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: CachedNetworkImage(
                      placeholder:(context,s)=> Icon(Icons.camera),
                      imageUrl: imgList[0],
                      fit: BoxFit.fill,
                     // width: MediaQuery.of(context).size.width / 1.05,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                ),
              ),
            ),
            /*Padding(
              padding:  EdgeInsets.all(0.0),
              child: ListView.separated(
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Image.network(
                              imgList[0],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: MediaQuery.of(context).size.height / 5,
                            ),
                            Column(
                              */ /*mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,*/ /*
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width- MediaQuery.of(context).size.width / 3,
                                  child: Padding(
                                    padding:  EdgeInsets.all(listPadding/5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width / 1.74,
                                          child: FittedBox(fit:BoxFit.contain,child: Text(modelProducts.data[index].name)),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),

                                        Icon(
                                            Icons.add_circle_outline,
                                            color: colorPrimary,
                                            size: MediaQuery.of(context).size.width/18
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width- MediaQuery.of(context).size.width / 3,
                                  child: Padding(
                                    padding:  EdgeInsets.all(listPadding/5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        rateWidget(modelProducts, index),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text( modelProducts.data[index].price,style:TextStyle(fontSize: MediaQuery.of(context).size.width/18),),
                                        //  rateWidget(modelProducts, index),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => new Divider(),
              ),
            ),*/
SizedBox(height: 30.0,),
            MyTextWidgetLabel(
                S.of(context).bestSeller, "label", colorBorder, textLabelSize),
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: ListView.separated(
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  String name = modelProducts!.data![index].name!;
                  if (name.length > 22) {
                    name = name.substring(0, 22) + '...';
                  }
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: colorPrimary,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                  modelProducts: modelProducts!.data![index],
                                )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                         // width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4.5,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                AspectRatio(
                                  aspectRatio: 4.5/6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                     placeholder:(context,s)=> Icon(Icons.camera),imageUrl: imgList[0],
                                        fit: BoxFit.cover,
                                       // width: MediaQuery.of(context).size.width / 3.7,
                                        height:
                                            MediaQuery.of(context).size.height / 5,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  /*mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,*/
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width / 2.8,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            end: listPadding!,
                                            top: listPadding! * 1.2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.8,
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .headline3!
                                                        .fontSize),
                                              ),
                                            ),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Icon(Icons.add_circle_outline,
                                                color: colorPrimary,
                                                size: 14.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width / 2.8,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            end: listPadding!,
                                            bottom: listPadding! * 1.2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            rateWidget(modelProducts!, index),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                              modelProducts!.data![index].price! + ' ' + modelSettings!.data![0].value!,
                                              style: TextStyle(fontSize: 14.0),
                                                 /* fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          RateTextDividerBy/2),*/
                                            ),
                                            //  rateWidget(modelProducts, index),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => new Divider(),
              ),
            )
          ],
        ),
      );
    }
  }

  fetchUrls(ModelAds modelAds) {
    List urls = [];
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    for (int i = 0; i < modelAds.data!.length; i++) {
      String url = Api.uri + '/' + modelAds.data![i].image!;
      urls.add(url);
    }
    return urls;
  }


  rateWidget(ModelProducts modelProducts, int index) {
    if (modelProducts.data![index].rate != null) {
      return Row(
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Icon(
              Icons.star_rate_rounded,
              color: colorPrimary,
              size: MediaQuery.of(context).size.width / RateTextDividerBy,
            ),
          ),
          FittedBox(
              fit: BoxFit.contain,
              child: Text(
                modelProducts.data![index].rate!,
                style: TextStyle(
                    fontSize:
                        14.0,
              )),
          )],
      );
    } else {
      return Text('');
    }
  }

  getScreenUi() {
    if (!internet &&
        ( modelAds == null)) {
      hideScrollBar();
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
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
                    fit: BoxFit.contain, child: Text(S.of(context).noInternet))),
          ],
        ),
      );
    } else if ((modelAds != null && modelCats != null && modelProducts != null && modelSettings != null ) && ( modelAds!.path == 'slint' || modelCats!.path == 'slint' || modelProducts!.path == 'slint' || modelSettings!.path == 'slint' ) ) {
     /* Fluttertoast.showToast(
          msg: S.of(context).slowInternet,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
      hideScrollBar();
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
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
                    CupertinoIcons.speedometer ,
                    color: colorPrimary,
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                    fit: BoxFit.contain, child: Text(S.of(context).slowInternet))),
          ],
        ),
      );
    }


    return getAppWidget(context);
  }
  scrollBarConfig()
  {
    if(isAlwaysShown)
    {
      Timer.periodic(Duration(milliseconds: 2100), (timer) {
        if(this.mounted) {
          setState(() {
            isAlwaysShown = false;
          });
        }
      });

    }
  }
  hideScrollBar()
  {
    setState(() {
      isAlwaysShown = false;
    });
  }
   initCache() {
    if (!kIsWeb) {
      getApplicationDocumentsDirectory().then((dir) {
        Api.cacheStore =
            DbCacheStore(databasePath: dir.path, logStatements: true);
      });
    } else {
      Api.cacheStore = DbCacheStore(databasePath: 'db', logStatements: true);
    }
  }


  _getPriceUnit(BuildContext context , String key) async {
    print('exe price');
    ProviderUser.settingKey = key;
   //  provider2 = Provider.of<ProviderUser>(context, listen: false);
    if (!await MyApplication.checkConnection()) {
     // await Provider.of<ProviderUser>(context, listen: false).getSettingsData();
      setState(() {
        if(sharedPrefs.exertedPriceUnitKey.isEmpty){
          modelSettings = null;
          internet = false;
        }
        else
          {

              print('shared setting price');
              modelSettings = new ModelSetting();
              List<Datum2> datums = [];
              datums.add(Datum2(value:sharedPrefs.exertedPriceUnitKey));
              modelSettings!.data = datums;

          }
     //   modelSettings = Provider.of<ProviderUser>(context, listen: false).modelSettings;

      });
    } else {
      print('exeinternetprice');
      if(sharedPrefs.priceUnitKey == '') {
        await Provider.of<ProviderUser>(context, listen: false)
            .getSettingsData();


        if (this.mounted) {
          setState(() {

            modelSettings = Provider
                .of<ProviderUser>(context, listen: false)
                .modelSettings;
            SharedPrefs().priceUnit(modelSettings!.data![0].value.toString());
            SharedPrefs().exertedPriceUnit(modelSettings!.data![0].value.toString());
            // print(modelSettings!.data.toString()+'--------');
          });


        }
      }
      else{
        setState(() {
          print('shared setting price');
          modelSettings = new ModelSetting();
          List<Datum2> datums = [];
          datums.add(Datum2(value:sharedPrefs.priceUnitKey));
          modelSettings!.data = datums;
        });


      }
    }
  }
}
