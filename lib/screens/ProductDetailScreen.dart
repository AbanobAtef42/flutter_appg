import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app8/bottom_nav_routes/Cart.dart';
import 'package:flutter_app8/models/ModelSetting.dart';
import 'package:flutter_app8/models/modelUser.dart';
import 'package:flutter_app8/providers/providerHome.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/screens/CheckoutScreen.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:hive/hive.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app8/models/ModelProducts.dart';
import 'package:flutter_app8/styles/buttonStyle.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';


import 'package:webview_flutter/webview_flutter.dart';

class ProductDetail extends StatefulWidget {
  final Datum? modelProducts;

  //final div = new DivElement();
  ProductDetail({this.modelProducts});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
   Box<Datum>? box;
  late Box<Datum>? boxFavs;
  Box<User>? boxUser;
  bool visible = false;
  bool _visible = false;
  FocusNode? _focusNode;
  GlobalKey? _dropdownButtonKey;
  String? buttonCartText;
  ScrollController? _hideButtonController;
  WebViewController? _webViewController;
  var _isVisible;
  bool dialogIsShown = false;
  TextEditingController _buttonCartController = new TextEditingController();
  List<String?> dropDownValues = [];
  List<GlobalKey> dropDownButtons = [];
  int counter = 1;
  double? scrollExpandedHeight;
  Icon _iconHeart = Icon(
    CupertinoIcons.heart,
    color: Colors.white,
    size: 35,
  );
  Icon _iconBack = Icon(
    Icons.arrow_back,
    color: Colors.white,
    size: 30,
  );
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  String? var1;
  late bool isExist;
  bool? isExistFav;

  bool isAlwaysShown = true;
  var focus;
  late bool varsExist;

  late AwesomeDialog awesomeDialog;

  ProviderUser? provider2;

  ModelSetting? modelSettings;

  @override
  initState() {
    dropDownValues =
        List.generate(widget.modelProducts!.vars!.length, (value) => null);
    dropDownButtons =
        List.generate(widget.modelProducts!.vars!.length, (value) => GlobalKey());

    super.initState();
    _focusNode = new FocusNode();
    box = Hive.box(dataBoxName);
    boxFavs = Hive.box(dataBoxNameFavs);

    // boxUser = Hive.box<User>(dataBoxNameUser);
    onIconHeartStart();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController!.addListener(() {
      if (_hideButtonController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          /* only set when the previous state is false
             * Less widget rebuilds
             */
          //  print("**** ${_isVisible} up"); //Move IO away from setState
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController!.position.atEdge) {
          if (_hideButtonController!.position.pixels == 0) {
            if (_isVisible == false) {
              /* only set when the previous state is false
               * Less widget rebuilds
               */
              // print("**** ${_isVisible} down"); //Move IO away from setState
              setState(() {
                _isVisible = true;
              });
            }
          }
        }
      }
    });
  }

  @override
  dispose() {
    awesomeDialog.dissmiss();
   // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();

    // Exit full screen
  }

  @override
  Widget build(BuildContext context) {
    if (scrollExpandedHeight == null) {
      scrollExpandedHeight = MediaQuery.of(context).size.height / 3;
    }
   // if (widget.div == null) {
    //  widget.div.appendHtml(widget.modelProducts.description);
    //}
    if (buttonCartText == null) {
      buttonTextWidget();
    }

    getDialogue(context);
    if (isAlwaysShown) {
      scrollBarConfig();
    }
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        return true;
      },
      child: SafeArea(
        child: Scaffold(

          body: Stack(children: [
            RawScrollbar(
              thumbColor: colorPrimary,
              isAlwaysShown: isAlwaysShown,
              radius: Radius.circular(scrollBarRadius),
              child:
                  CustomScrollView(controller: _hideButtonController, slivers: <
                      Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: scrollExpandedHeight,
                  automaticallyImplyLeading: false,
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: scrollExpandedHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Material(
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Navigator.pop(context);
                                  SystemChrome.setEnabledSystemUIOverlays(
                                      SystemUiOverlay.values);
                                },
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                                child: _iconBack)),
                        Spacer(
                          flex: 10,
                        ),
                        Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                                onTap: () => onIconHeartClick(),
                                child: _iconHeart)),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: [
                    Column(
                      children: [
                        SizedBox(
                           height: 10.0,),
                        CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              height: scrollExpandedHeight! -10.0,
                              autoPlayInterval: Duration(seconds: 2),
                              viewportFraction: 1.0),
                          items: imgList
                              .map((item) => Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 8.0, end: 8.0, top: 8.0),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio:1/1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 0.0),
                                            child: new Align(
                                              alignment: Alignment.center,
                                              child: CachedNetworkImage(
                                   placeholder:(context,s)=> Icon(Icons.camera),imageUrl: item,

                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ])),
                ),

                /*SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('Grid Item $index'),
                  );
                },
                childCount: 20,
                  ),
          ),
          SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('List Item $index'),
                  );
                },
                  ),
          ),*/
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 16.0, start: 16.0, end: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        widget.modelProducts!.name!,
                                        style:
                                            Theme.of(context).textTheme.headline2,
                                      )))),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 16.0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: rateWidget(widget.modelProducts!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 16.0, end: 16.0),
                            child: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Text(
                                widget.modelProducts!.price! + ' EGP',
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width /
                                        RateTextDividerBy),
                              ),
                            ),
                          ),
                          new MarkdownBody(
                              data: html2md
                                  .convert(widget.modelProducts!.description!)),
                          /* WebView(
                      initialUrl: 'about:blank',
                      onWebViewCreated: (WebViewController webViewController) {
                        webViewController = webViewController;
                        _loadHtml();
                      },
                    ),*/

                          SizedBox(
                              height: MediaQuery.of(context).size.height / 24),
                          varsWidget(),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 24),
                          //  parseHtmlDocument(widget.modelProducts.description)
                          quantityWidget(),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  textFieldButtonDividerLogin),
                          Center(
                            child: MyButton(
                              onClicked: () => onButtonClick(),
                              child: Text(
                                buttonCartText!,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  textFieldButtonDividerLogin /
                                  2),
                          Visibility(
                            visible: visible,
                            child: Center(
                              child: Styles.getButton(
                                  context,
                                  Text(
                                    S.of(context).checkOutBtn,
                                    style: Styles.getTextAdsStyle(),
                                  ),
                                  () => onClickedCheck(),
                                  Styles.getButtonCheckoutStyle()),
                            ),
                          ),

                          SizedBox(
                            height: scrollExpandedHeight,
                          ), /*MediaQuery.of(context).size.height /
                                  textFieldButtonDividerLogin),*/
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Column(children: [
              SizedBox(height: scrollExpandedHeight),
              Visibility(
                visible: _isVisible,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10.0),
                  child: new Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: FractionalTranslation(
                      translation: Offset(0.0, -0.5),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        elevation: 12.0,
                        splashColor: colorPrimary,
                        onPressed: () {
                        //  Share.share( 'https://foryou.flk.sa/store/' + widget.modelProducts!.slug.toString());

                        },
                        child: Icon(
                          Icons.share_rounded,
                          color: colorPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  onIconHeartClick() {
    print('fffffffffffdddd');
    if (this._iconHeart.icon == CupertinoIcons.heart) {
      print('ffffffffffffff');
      boxFavs!.add(widget.modelProducts!);
      setState(() {
        this._iconHeart = new Icon(
          CupertinoIcons.heart_fill,
          color: Colors.red,
        );
      });
    } else {
      setState(() {
        this._iconHeart = new Icon(
          CupertinoIcons.heart,
          color: Colors.white,
        );
        Iterable<dynamic> key = boxFavs!.keys.where(
            (element) => boxFavs!.get(element)!.id == widget.modelProducts!.id);
        boxFavs!.delete(key.toList()[0]);
      });
    }
  }

  onIconHeartStart() {
    print('fffffffffffdddd');
    List<Datum?> datums = boxFavs!.values
        .where((element) => element.id == widget.modelProducts!.id)
        .toList();

    if (datums.length != 0) {
      print('ffffffffffffff');
      setState(() {
        this._iconHeart = new Icon(
          CupertinoIcons.heart_fill,
          color: Colors.red,
        );
        isExistFav = true;
      });
    } else {
      setState(() {
        this._iconHeart = new Icon(
          CupertinoIcons.heart,
          color: Colors.white,
        );
        isExistFav = false;
      });
    }
  }

  rateWidget(Datum modelProducts) {
    if (modelProducts.rate != null) {
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
                modelProducts.rate!,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width / RateTextDividerBy),
              )),
        ],
      );
    } else {
      return Text('');
    }
  }

  quantityWidget() {
    return Row(
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
        Spacer(),
        Visibility(
            visible: _visible,
            child: CircularProgressIndicator(

            )),
        Spacer(),
      ],
    );
  }

  onPressAdd() {
    setState(() {
      counter++;
    });
  }

  onPressMinus() {
    if (counter != 1) {
      setState(() {
        counter--;
      });
    }
  }

  varsWidget() {
    varsExist = !(widget.modelProducts!.vars == null ||
        widget.modelProducts!.vars!.length == 0);
    if (!varsExist) {
      return SizedBox(
        height: 0.0,
      );
    } else {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.modelProducts!.vars!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // _focusNode = new FocusNode();

            //  _dropdownButtonKey = new GlobalKey();
            // dropDownButtons.add(_dropdownButtonKey);
            // FocusScope.of(context).requestFocus(_focusNode);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap:()=> openDropdown(dropDownButtons[index]),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        border: Border.all(color: colorBorder),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: DropdownButton<String>(
                        key: dropDownButtons[index],
                        underline: Text(''),
                        hint: Text(widget.modelProducts!.vars![index].name!),
                        value: dropDownValues[index],
                        focusNode: _focusNode,
                       // onTap: () => openDropdown(dropDownButtons[index]),
                        onChanged: (String? value) {
                          setState(() {
                            dropDownValue(index, value);
                          });
                        },
                        items: widget.modelProducts!.vars![index].value!
                            .map((value) => DropdownMenuItem<String>(
                                  value: value.label,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        value.label!,
                                        style: TextStyle(color: Colors.black),
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
            );
          });
    }
  }

  @override
  bool operator ==(dynamic other) =>
      other != null && other is String && this.var1 == other.toString();

  @override
  int get hashCode => super.hashCode;

  dropDownValue(int index, String? value) {
    dropDownValues[index] = value;
  }

  onButtonClick() async {
    buttonTextWidget();
    if (!await MyApplication.checkConnection()) {
      MyApplication.getDialogue(
          context, S.of(context).noInternet, '', DialogType.ERROR);
    } else if (varsExist && !isExist) {
      bool state = await _checkInventoryForOrder();
      setState(() {
        _visible = false;
      });

      if (state) {
        storeOrDelete(isExist);
      }
    } else {
      storeOrDelete(isExist);
    }
  }

  buttonTextWidget() {
    // keys = keys.where((element) => items.get(element).id == widget.modelProducts.id).toList();

    List<Datum>? datums = box!.values
        .where((element) => element.id == widget.modelProducts!.id)
        .toList();

    if (datums.length != 0) {
     // print('forrrrrrrrrrr' + ' id ' + datums[0]!.id.toString());
      print('element ' + widget.modelProducts!.id.toString());

      if (this.mounted) {
        setState(() {
          isExist = true;
          visible = true;
          buttonCartText = S.of(context).delFCart;
        });
      }
    } else {
      print('forrrrrrrrrrrN');
      if (this.mounted) {
        setState(() {
          isExist = false;
          visible = false;
          buttonCartText = S.of(context).cartAdd;
        });
      }
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

  Future<bool> _checkInventoryForOrder() async {
    Api.context = context;

    if (!dropDownValues.contains(null)) {
      setState(() {
        _visible = true;
      });
     List <String?> vars = [];
      for (int i = 0; i < dropDownValues.length; i++) {
        /*if (i == 0) {
          vars += dropDownValues[i]! + ',';
        } else if (i == dropDownValues.length - 1) {
          vars += dropDownValues[i]!;
        }*/
        vars.add(dropDownValues[i].toString());
      }
     await _getStockid(context, "order.stock");
     // print('hhhhhhhhhhhhhhhhh'+modelSettings!.data![0].value.toString());
      Map<String, Object?> data = {
        "product_id": widget.modelProducts!.id,
        "qnt": counter.toString(),
        "stock_id": modelSettings!.data![0].value,
        "options": vars
      };
      print('dddddddddddddddd'+ data.toString());

      final provider = Provider.of<ProviderHome>(context, listen: false);

      await provider.checkInventoryForOrder(data);
      // if (!provider.loading) {
      setState(() {
        _visible = false;
      });
      if (provider.state == 's') {
        return true;
      } else {
        return false;
      }

      // MyApplication.showAlertDialog(context, signed, '', '');

    } else {
      final snackBar = SnackBar(content: Text(S.of(context).fillIn));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      openDropdown(dropDownButtons[dropDownValues.indexOf(null)]);
      return false;
    }
  }

  void openDropdown(GlobalKey globalKey) {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext? element) {
      element!.visitChildElements((element) {
        if ( element.widget is GestureDetector) {
          detector = element.widget as GestureDetector?;
         // return false;
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
   _getStockid(BuildContext context , String key) async {
     print('exe stock');
     ProviderUser.settingKey = key;
     provider2 = Provider.of<ProviderUser>(context, listen: false);
     if (!await MyApplication.checkConnection()) {
       await provider2!.getSettingsData();
       setState(() {
         modelSettings = provider2?.modelSettings;
        // internet = false;
       });
     } else {
       print('exeinternetprice');
       await provider2!.getSettingsData();
       if (this.mounted) {
         setState(() {
           modelSettings = provider2?.modelSettings;
           // print(modelSettings!.data.toString()+'--------');
         });
       }
     }
   }

  storeOrDelete(bool isExist) {
    if (isExist) {
      print('exisssssssssss');
      Iterable<dynamic> key =
          box!.keys.where((key) => box!.get(key)!.id == widget.modelProducts!.id);

      box!.delete(key.toList()[0]);

      setState(() {
        buttonCartText = S.of(context).cartAdd;
        isExist = false;
        visible = false;
      });
    } else {
      print('exisssssssssssN');
      box!.add(widget.modelProducts!);
      awesomeDialog.show();
      setState(() {
        buttonCartText = S.of(context).delFCart;
        isExist = true;
        visible = true;
        dialogIsShown = true;
        //awesomeDialog.show();
      });
    }
  }

  onClickedCheck() {
    if (!dropDownValues.contains(null)) {
      List<String?> options;
      options = dropDownValues;
      int qnt = counter;
      dismiss();

      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckOut(widget.modelProducts, options, qnt)),
      );
    } else {
      final snackBar = SnackBar(content: Text(S.of(context).fillIn));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      openDropdown(dropDownButtons[dropDownValues.indexOf(null)]);
      return false;
    }
  }

  getDialogue(BuildContext context) {
    awesomeDialog = AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,

      dismissOnTouchOutside: false,
      btnOk: Text(''),
      // showCloseIcon: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imgList[0],
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 3,
          ),
          Text(
            S.of(context).addedSuccessfullyToCart,
            style: Styles.getTextAdsStyle(),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: MyButton(
              onClicked: () => onClickedCheck(),
              child: Text(S.of(context).checkOutBtn),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Styles.getButton(
              context,
              Text(S.of(context).continueShopping,
                  style: Styles.getTextAdsStyle()),
              dismiss,
              Styles.getButtonCheckoutStyle(),
            ),
          ),
        ],
      ),

      btnOkOnPress: () {},
    );
  }

  dismiss() {
    print('dismiss executedddddd');
    if (dialogIsShown) {
      awesomeDialog.dissmiss();
      setState(() {
        dialogIsShown = false;
      });
    }
  }
}
