import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/icons/my_flutter_app_icons.dart';
import 'package:flutter_app8/models/ModelOrders.dart';
import 'package:flutter_app8/models/ModelSetting.dart';
import 'package:flutter_app8/providers/providerHome.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

import 'CustomerOrdersDetailScreen.dart';

class Orders extends StatefulWidget
{
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  double? statusBarHeight;

  bool internet = true;
  ModelOrders? modelOrders;
late ProviderHome provider;
  double? listPadding;

  bool isAlwaysShown = true;

  ModelSetting? modelSettings;
  @override
  void initState() {
    _getPriceUnit(context, 'admin.\$');
    super.initState();
    MyApplication.initCache();

    _getOrdersData(context);

  }

  @override
  Widget build(BuildContext context) {
    if (listPadding == null) {
      listPadding = MediaQuery.of(context).size.width / 25;
    }
    if(statusBarHeight == null)
    {
      statusBarHeight = MediaQuery.of(context).padding.top;
    }
    scrollBarConfig();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: Styles.getAppBarStyle(context, S.of(context).orders, Octicons.list_ordered),
      body: Container(
      color: Colors.grey[300],
     // height: MediaQuery.of(context).size.height,
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
    );
  }
  getScreenUi() {

    if (!internet && modelOrders == null) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.grey[300],
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
    } else if (modelOrders != null  &&  modelOrders!.path == 'slint'  ) {
      /* Fluttertoast.showToast(
          msg: S.of(context).slowInternet,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.grey[300],
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
  Widget getAppWidget() {
    if (modelOrders == null || modelSettings == null) {
      return
        //  MyTextWidgetLabel('loading.....', 'l', Colors.black, textLabelSize);
        Container(
          height: MediaQuery.of(context).size.height/1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
          CircularProgressIndicator(

          ),
          ]),
        );

    } else {

      List orders = modelOrders!.data!;
      final List<String> imgList = [
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
        // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
        // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
      ];
      if (modelOrders!.data != null && modelOrders!.data!.length == 0) {
        //hideScrollBar();
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
                      FontAwesome.dropbox,
                      color: colorPrimary,
                    )),
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: FittedBox(
                      fit: BoxFit.contain, child: Text('You Don\'t Have Orders Yet'))),
            ],
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.only(top: 0.0,bottom: 0.0,right: 0.0,left: 0.0),
        child: Container(
          height: MediaQuery.of(context).size.height/1.2,
          child: RawScrollbar(
            radius: Radius.circular(scrollBarRadius),
            thumbColor: colorPrimary,
            isAlwaysShown: isAlwaysShown,

            child: ListView.builder(
                itemCount: orders.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  if(modelOrders!.data![index].items!.length == 0)
                  {
                    return Text('');
                  }
                  print('length :'+ orders.length.toString());
                  String name = modelOrders!.data![index].items![0].productId!.name!;
                  if (name.length > 22) {
                    name = name.substring(0, 22) + '...';
                  }
                  return InkWell(
                    onTap: ()=> Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>CustomerOrdersDetail(orders[index]) ),),
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0,bottom: 12.0,right: 8.0,left: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          color: Colors.white,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: colorPrimary,
                              /*onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                      modelProducts: modelProducts.data[index],
                                    )
                                ),
                              ),*/
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width/1.2,
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
                                                width:
                                                MediaQuery.of(context).size.width / 3.7,
                                                height:
                                                MediaQuery.of(context).size.height / 4.5,
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
                                                  MediaQuery.of(context).size.width / 2.5,
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
                                                    Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                      children:[ Container(
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
                                                        SizedBox(height: 10,),

                                                        optionsWidget(modelOrders!.data![index]),
                                                    ]),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    /*Icon(Icons.add_circle_outline,
                                                        color: colorPrimary,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            18),*/
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width -
                                                  MediaQuery.of(context).size.width / 2.5,
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
                                                    Text(
                                                      modelOrders!.data![index].status!,
                                                      style: TextStyle(
                                                        color: colorPrimary,
                                                          fontSize:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              RateTextDividerBy),
                                                    ),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    Text(
                                                      modelOrders!.data![index].total.toString()+' '+modelSettings!.data![0].value!,
                                                      style: TextStyle(
                                                          fontSize:
                                                          14.0),
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
                          ),
                        ),
                      ),
                    ),
                  );
                },
               // separatorBuilder: (context, index) => new Divider(),
              ),
          ),
        ),
      );
    }
  }
  getOptions(Datum modelOrders) {
    String optionsData = "";
    // Log.e("vars_length",String.valueOf(datumCustomerOrders.getItems().get(0).productId.getVars().size()));
    for(int i=0 ; i<modelOrders.items![0].productId!.vars!.length; i++)
    {
      if(i == modelOrders.items![0].productId!.vars!.length-1) {
        optionsData = optionsData + modelOrders.items![0].productId!.vars![i].name! + " : " + modelOrders.items![0].options![i];
      }
      else
      {
        optionsData = optionsData + modelOrders.items![0].productId!.vars![i].name!+ " : " + modelOrders.items![0].options![i] + " | ";
      }
    }

    return optionsData ;
  }
 Widget optionsWidget(Datum modelOrders)
  { return modelOrders.items!.length == 0 ?  Text(''):
     Text(getOptions(modelOrders),textDirection: TextDirection.rtl,style: Styles.getTextGreyStyle(context),);
  }
  _getOrdersData(BuildContext context) async {
    Api.context = context;
    provider = Provider.of<ProviderHome>(context, listen: false);


    //  return;

    if (!await MyApplication.checkConnection()) {
      Api.context = context;
      print('iduser'+sharedPrefs.getCurrentUserId);
      await Provider.of<ProviderHome>(context, listen: false).getOrders(sharedPrefs.getCurrentUserId);

      setState(() {
        modelOrders = provider.modelOrders;
        internet = false;
      });
    } else {
      print('iduser'+sharedPrefs.getCurrentUserId);
      await Provider.of<ProviderHome>(context, listen: false).getOrders(sharedPrefs.getCurrentUserId);
      setState(() {
        modelOrders = provider.modelOrders;

      });
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