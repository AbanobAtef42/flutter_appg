import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/icons/my_flutter_app_icons.dart';
import 'package:flutter_app8/models/ModelCats.dart';
import 'package:flutter_app8/models/ModelProducts.dart';
import 'package:flutter_app8/models/ModelSetting.dart';
import 'package:flutter_app8/providers/providerHome.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/screens/ProductDetailScreen.dart';
import 'package:flutter_app8/styles/styles.dart';
import 'package:flutter_app8/styles/textWidgetStyle.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  final String catQuery;
  final String searchQuery;

  static String name = 'category';
  const Categories(this.catQuery,this.searchQuery);

  //static bool listen = true;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  ModelCats? modelCats;
  ModelProducts? modelProducts;
  ModelProducts? modelProducts2;
  double? listPadding;
  String catQuery = '';
  String trendQuery = '';
  String searchQuery = '';
  double? statusBarHeight;
  bool listen = true;
  int index1 = 0;
  Icon _searchIcon = new Icon(Icons.search);
  FocusNode focusNode = new FocusNode();
  // IconButton _searchIconButton = new IconButton();
  TextEditingController textEditingController = new TextEditingController();
  ProviderHome? provider;

  bool loading = false;
  bool adsSlow = false;
  bool catsSlow = false;
  bool prosSlow = false;
  bool internet = true;

  var x = 0;

  var _appBarTitle;
 // ScrollController? _scrollController;

  bool? isAlwaysShown;

  bool internetp = true;

  ModelSetting? modelSettings;

  late List<GlobalKey<State<StatefulWidget>>> tags;


  @override
  void initState() {
  //  _scrollController = ScrollController();

    isAlwaysShown = true;
    catQuery = widget.catQuery;
    searchQuery = widget.searchQuery;
    _getCats(context);
    _getPriceUnit(context, 'admin.\$');
    _getProducts(context, -1);
    super.initState();

    MyApplication.initCache();
  }

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(),
      query: searchQuery,
    );
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    /*Fluttertoast.showToast(
        msg: 'build : build ',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: colorPrimary,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: textLabelSize);*/
    return Scaffold(
      /*appBar: AppBar(
                title: Text(cats,
              ),*/
      resizeToAvoidBottomInset: true,
      appBar: _buildBar(context) as PreferredSizeWidget?,
      body: RawScrollbar(
        thumbColor: colorPrimary,
        isAlwaysShown: isAlwaysShown,
        // controller: _scrollController,
        radius: Radius.circular(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 0,
            ),
            getScreenUi(),
          ],
        ),
      ),
    );
  }

  Widget getAppWidget(BuildContext context) {
    /*Fluttertoast.showToast(
        msg: '22 : _getAppWidget ',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: colorPrimary,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: textLabelSize);*/
    if (modelCats == null || modelProducts == null || modelSettings == null) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(

          ),
        ]),
      );
    }
   /* setState(() {
        provider = Provider.of<ProviderHome>(context,listen: false);
        loading = false;
      });*/
    // loading = false;
    List cats = modelCats!.data!;
    provider = Provider.of<ProviderHome>(context, listen: false);

/*setState(() {
  provider = Provider.of<ProviderHome>(context, listen: true);
});*/
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: cats.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  if (index == index1) {
                    return GestureDetector(
                      onTap: () =>
                          onListItemTap(modelCats, index, context, provider),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 1.0,
                                  bottom: 1.0),
                              child: Center(
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Center(
                                          child: Text(
                                        cats[index].name,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                        textAlign: TextAlign.center,
                                      )))),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () =>
                        onListItemTap(modelCats, index, context, provider),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Center(
                                    child: Text(
                                  cats[index].name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ))),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
        Container(
          height: 1.0,
          color: Colors.grey,
          width: MediaQuery.of(context).size.width / 1.1,
        ),
        _getProductWidget(modelProducts),
      ],
    );
  }

  rateWidget(ModelProducts modelProducts, int index) {
    if (modelProducts.data![index].rate != null) {
      return Row(
        children: [
          Icon(
            Icons.star_rate_rounded,
            color: colorPrimary,
            size: 14.0,
          ),
          Text(
            modelProducts.data![index].rate!,
          ),
        ],
      );
    }
  }

  _getCats(BuildContext context) async {

    final provider = Provider.of<ProviderHome>(context, listen: false);
    if (!await MyApplication.checkConnection()) {
      await Provider.of<ProviderHome>(context, listen: false).getCats2();
      setState(() {
        modelCats = provider.modelCats2;
        internet = false;
      });
    } else {
      await Provider.of<ProviderHome>(context, listen: false).getCats2();
      if (this.mounted) {
        setState(() {
          modelCats = provider.modelCats2;
        });
      }
    }
  }

  _getProducts(BuildContext context, int index) async {
    Api.context = context;
    // Directory path = await getApplicationDocumentsDirectory();
    //Api.cacheStore =  DbCacheStore(databasePath: path.path, logStatements: true);
    /*getApplicationDocumentsDirectory().then((dir) {
      CacheStore cacheStore = DbCacheStore(databasePath: dir.path, logStatements: true);
      Api.dio = Dio(Api.options);
      Api.dio.interceptors.add(DioCacheInterceptor(options: CacheOptions(store: cacheStore)));

   setState(() {

   });


      // Api().path = dir.path;
    });*/

    provider = Provider.of<ProviderHome>(context, listen: false);
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    // loading = true;
    /*if(modelProducts != null) {
      if (Provider
          .of<ProviderHome>(context, listen: false)
          .modelProductsCats
          .data != null) {
        Provider
            .of<ProviderHome>(context, listen: false)
            .modelProductsCats
            .data
            .clear();
      }
    }*/

    await Provider.of<ProviderHome>(context, listen: false)
        .getProductsCats(catQuery, searchQuery, trendQuery);
     if(this.mounted && index == -1){
       modelProducts = new ModelProducts();
     }
    if ((this.mounted && index == -1) ||
        (this.mounted &&
            modelCats != null &&
            catQuery == modelCats!.data![index].slug)) {
      if (!await MyApplication.checkConnection()) {
        setState(() {
          modelProducts = provider!.modelProductsCats;
          internetp = false;
          loading = false;

        });
      } else {
        setState(() {
          internetp = true;
          loading = false;
          modelProducts = provider!.modelProductsCats;
          /*if(modelProducts == null)
          {
            modelProducts = new ModelProducts();
          }*/
        });
      }
    }

    //  modelProducts2 = modelProducts;
    /* setState(() {
         provider = Provider.of<ProviderHome>(context,listen: false);
       });*/
  }

  _getProductsBuild(BuildContext context) async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // provider = Provider.of<ProviderHome>(context, listen: false);

      Provider.of<ProviderHome>(context, listen: false)
          .getProducts('', searchQuery, '');
    });
    modelProducts = provider!.modelProducts;
  }

  /*_getProducts(BuildContext context) async {
    Fluttertoast.showToast(
        msg: '11 : _getProductWidget ',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: colorPrimary,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: textLabelSize);
   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider = Provider.of<ProviderHome>(context,listen: false);
      Provider.of<ProviderHome>(context,listen: false)
          .getProducts('', '', searchQuery);
      modelProducts = provider.modelProducts;
   // ProductWidget('', '', '');
   // });

   // if (provider.loaded) {
    //  modelProducts =  Provider.of<ProviderHome>(context,listen: false).modelProducts;
   // ProductWidget('', '', '');
  //  }
  }*/

  _getProductsByCat(BuildContext context, String catQuery) async {
    // modelProducts2 = null;
    final provider = Provider.of<ProviderHome>(context);
    await Provider.of<ProviderHome>(context).getProducts('', '', catQuery);
    modelProducts2 = provider.modelProducts;
    // _getProductWidget();
  }

  onListItemTap(ModelCats? modelCats, int index, BuildContext context,
      ProviderHome? providerHome) async {
    /*final provider = Provider.of<ProviderHome>(context);
    provider.getCatIndex(index);*/
//Timer(Duration(seconds: ))
    //  Provider.of<ProviderHome>(context,listen: false).modelProductsCats.data.clear();
    FocusNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    provider = Provider.of<ProviderHome>(context, listen: false);

   // modelProducts = provider.modelProductsCats;
    setState(() {
      index1 = index;
      searchQuery = '';
      catQuery = modelCats!.data![index].slug!;
      trendQuery = '';
      loading = true;
     // this.modelCats = provider.modelCats;
      //modelProducts = new ModelProducts();


      _getProducts(context, index);
    });
  }

  Widget _getProductWidget(ModelProducts? modelProducts) {
    //loading = provider.loadedCats;
    // List<Datum> list = modelProducts.data;
    /*  setState(() {
      provider = Provider.of<ProviderHome>(context,listen: false);
    });*/
    if (listPadding == null) {
      listPadding = MediaQuery.of(context).size.width / 25;
    }

    if (!internetp && modelProducts == null) {
      hideScrollBar();
      print('noooooooooooooooooo');
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
                    fit: BoxFit.contain,
                    child: Text(S.of(context).noInternet))),
          ],
        ),
      );
    } else if (modelProducts!.path == 'slint') {
      /*Fluttertoast.showToast(
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
                    MyFlutterApp.slow_internet,
                    color: colorPrimary,
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(S.of(context).slowInternet))),
          ],
        ),
      );
    }

    if (loading) {
      hideScrollBar();
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(

              )),
        ),
      );
    }
    if (modelProducts.data != null && modelProducts.data!.length == 0) {
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
                    Icons.search_off_outlined,
                    color: colorPrimary,
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                    fit: BoxFit.contain, child: Text(S.of(context).noResults))),
          ],
        ),
      );
    }

    if (modelProducts.data != null && modelProducts.data!.length > 0) {
      // modelProducts.data.clear();
      List<Datum> products = modelProducts.data!;
      tags =
          List.generate(products.length*2, (value) => GlobalKey());

      final List<String> imgList = [
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
        // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
        // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
      ];
      /*return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.4,
          child: ListView.separated(
            itemCount: products.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network(
                          imgList[0],
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 3.5,
                          height: MediaQuery.of(context).size.width / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Text(modelProducts.data[index].name),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              rateWidget(modelProducts, index),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: colorPrimary,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(modelProducts.data[index].price),
                              //  rateWidget(modelProducts, index),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => new Divider(),
          ),
        ),
      );*/
      scrollBarConfig();
      return Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 3,
          child: ListView.separated(
            itemCount: products.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              List<String> itemTags = [];
              itemTags.add(products[index].slug.toString()) ;
              itemTags.add(products[index].name.toString()) ;
              String name = modelProducts.data![index].name!;
              if (name.length > 22) {
                name = name.substring(0, 22) + '...';
              }
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: colorPrimary,
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder<Null>(
                        pageBuilder: (BuildContext context, Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget? child) {
                                return Opacity(
                                  opacity: animation.value,
                                  child:ProductDetail(
                                    modelProducts: modelProducts.data![index],tags: itemTags,) ,
                                );
                              });
                        },
                        transitionDuration: Duration(milliseconds: 500)),
                  ),

                      /*context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(
                                modelProducts: modelProducts.data![index],
                              )
                      )
                  ),*/

                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                    //  width: MediaQuery.of(context).size.width,
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
                                  child: Hero(
                                    tag: products[index].slug.toString(),
                                    child: CachedNetworkImage(

                                       placeholder:(context,s)=> Icon(Icons.camera),
                                      imageUrl: imgList[0],

                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.of(context).size.width / 3.7,
                                      height:
                                          MediaQuery.of(context).size.height / 5,
                                    ),
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
                                          child: Hero(
                                            tag: products[index].name.toString(),
                                            child: Material(
                                              child: Text(
                                                modelProducts.data![index].name!,
                                                style: TextStyle(
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .headline3!
                                                        .fontSize),
                                              ),
                                            ),
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
                                        rateWidget(modelProducts, index),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          modelProducts.data![index].price! +
                                              ' '+ modelSettings!.data![0].value!,
                                          style: TextStyle(
                                              fontSize: 14.0),
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
        ),
      );
    } else {
      return Container();
    }

    /*return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Align(
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator(

            )),
      ),
    );*/
  }

/*getProductWidget2() {

  Consumer<ProviderHome>(
    builder: (_, snapShot, __) =>
        FutureBuilder<ModelProducts>(
            future: provider.modelProductsCats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  // modelProducts.data.clear();
                  // List products = provider.modelProductsCats.
                  final List<String> imgList = [
                    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
                    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                    // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                    // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
                    // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
                  ];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 1.3,
                      child: ListView.separated(
                        itemCount: snapshot.data.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.network(
                                      imgList[0],
                                      fit: BoxFit.cover,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 3.5,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            width:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width / 2.5,
                                            child: Text(
                                                snapshot.data.data[index].name),
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          rateWidget(snapshot.data, index),
                                        ],
                                      ),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 16.0, bottom: 16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: colorPrimary,
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Text(snapshot.data.data[index].price),
                                          //  rateWidget(modelProducts, index),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => new Divider(),
                      ),
                    ),
                  );
                } else {
                  return Text("No results");
                }
              } else if (snapshot.connectionState ==
                  ConnectionState.none) {
                return Container();
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
  );
}*/
  rateWidget2(ModelProducts modelProducts, int index) {
    if (modelProducts.data![index].rate != null) {
      return Row(
        children: [
          Icon(
            Icons.star_rate_rounded,
            color: colorPrimary,
          ),
          Text(modelProducts.data![index].rate!),
        ],
      );
    }
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: toolbarHeight,
        title: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: TextFormField(
            controller: textEditingController,
            style: Styles.getTextAdsStyle(),
            focusNode: focusNode,
            //  onTap: () => this._searchIcon = new Icon(Icons.close),
            onChanged: (str) => onChanged(str),
            onFieldSubmitted: (str) => onSubmitted(str),
            textInputAction: TextInputAction.search,
            // controller: _filter,
            decoration: new InputDecoration(
              prefixIcon: new IconButton(
                  icon: _searchIcon,
                  onPressed: () =>
                      _searchPressed(textEditingController, focusNode)),
              hintText: S.of(context).search,
            ),
          ),
        ));
  }

  void onChanged(String newVal) {
    if (newVal != '') {
      setState(() {
        this._searchIcon = new Icon(Icons.close);
      });
    } else {
      setState(() {
        this._searchIcon = new Icon(Icons.search);
      });
    }
  }

  _searchPressed(
      TextEditingController textEditingController, FocusNode focusNode) {
    // setState(() {
    if (this._searchIcon.icon == Icons.search) {
      /*setState(() {
       // this._searchIcon = new Icon(Icons.close);
      });*/

      focusNode.requestFocus();
      //  this._searchIconButton = new IconButton(icon: _searchIcon, onPressed: onPressed);
      /* this._appBarTitle =
            Container(
              width: MediaQuery.of(context).size.width/1.2,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: TextField(
              style: Styles.getTextDialogueStyle(),
           onSubmitted: onSubmitted(),
           // controller: _filter,
              decoration: new InputDecoration(

                  prefixIcon: new Icon(Icons.search),
                  hintText: searchHere
              ),

        ),
            );*/
    } else {
      setState(() {
        this._searchIcon = new Icon(Icons.search);
      });

      focusNode.unfocus();
      textEditingController.clear();
      // this._appBarTitle = new Text( 'Search Example' );

    }
    //  });
  }

  onPressed() {}
  onSubmitted(String query) async {
    //  setState(()  {
    if (!await MyApplication.checkConnection()) {
      MyApplication.getDialogue(context, S
          .of(context)
          .noInternet, '', DialogType.ERROR);
    }
    else {
      provider = Provider.of<ProviderHome>(context, listen: false);
      searchQuery = query;
      //   x = 0;
      this._searchIcon = new Icon(Icons.search);
      // modelProducts = null;
      //
      // provider = Provider.of<ProviderHome>(context, listen: false);

      modelProducts = provider!.modelProductsCats;
      setState(() {
        searchQuery = query;
        loading = true;
        _getProducts(context, -1);

        // });
      });
    }
  }

  getScreenUi() {
    if (!internet && (modelCats == null || modelProducts == null )) {
      hideScrollBar();
      /*Fluttertoast.showToast(
          msg: S.of(context).noInternet,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
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
                    fit: BoxFit.contain,
                    child: Text(S.of(context).noInternet))),
          ],
        ),
      );
    } else if ((modelCats != null && modelProducts != null) &&
        (modelCats!.path == 'slint' || modelProducts!.path == 'slint')) {
      hideScrollBar();
      /*Fluttertoast.showToast(
          msg: S.of(context).slowInternet,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: colorPrimary,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM);*/
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
                    MyFlutterApp.slow_internet,
                    color: colorPrimary,
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(S.of(context).slowInternet))),
          ],
        ),
      );
    }

    return getAppWidget(context);
  }

  scrollBarConfig() {
    if (isAlwaysShown!) {
      Timer.periodic(Duration(milliseconds: 2100), (timer) {
        if (this.mounted) {
          setState(() {
            isAlwaysShown = false;
          });
        }
      });
    }
  }

  hideScrollBar() {
    setState(() {
      isAlwaysShown = false;
    });
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
    } else  {
      print('exeinternetprice');
      if(sharedPrefs.priceUnitKey == '') {
        await Provider.of<ProviderUser>(context, listen: false)
            .getSettingsData();


        if (this.mounted) {
          setState(() {

            modelSettings = Provider
                .of<ProviderUser>(context, listen: false)
                .modelSettings;
            if(modelSettings != null) {
              SharedPrefs().priceUnit(modelSettings!
                  .data![0].value.toString());
              SharedPrefs().exertedPriceUnit(
                  modelSettings!.data![0].value.toString());
            }
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

class TheSearch extends SearchDelegate<String?> {
  TheSearch({this.contextPage, this.controller});

  BuildContext? contextPage;
  TextEditingController? controller;
  // final suggestions1 = ["https://www.google.com"];

  /*@override
  String get searchFieldLabel => S.of(context).search;*/

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
