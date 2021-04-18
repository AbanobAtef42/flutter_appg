// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, jsonDecode, utf8;
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app8/generated/l10n.dart';
import 'package:flutter_app8/models/ModelAds.dart';
import 'package:flutter_app8/models/ModelCats.dart';
import 'package:flutter_app8/models/ModelOrders.dart' hide Datum ;
import 'package:flutter_app8/models/ModelProducts.dart';
import 'package:flutter_app8/models/ModelSetting.dart';
import 'package:flutter_app8/models/ModelsGoverns.dart';
import 'package:flutter_app8/models/modelUser.dart';
import 'package:flutter_app8/providers/providerHome.dart';
import 'package:flutter_app8/providers/providerUser.dart';

import 'package:flutter_app8/values/myApplication.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'SharedPreferenceClass.dart';
import 'myConstants.dart';



/// For this app, the only [] endpoint we retrieve from an API is Currency.
///
/// If we had more, we could keep a list of [Categories] here.
const apiCategory = {
  'login': 'login',
};

/// The REST API retrieves unit conversions for [Categories] that change.
///
/// For example, the currency exchange rate, stock prices, the height of the
/// tides change often.
/// We have set up an API that retrieves a list of currencies and their current
/// exchange rate (mock data).
///   GET /currency: get a list of currencies
///   GET /currency/convert: get conversion from one currency amount to another
class Api {
  Directory? root;

  String? path;
  static late CacheStore? cacheStore;

  /// We use the `dart:io` HttpClient. More details: https://flutter.io/networking/
  // We specify the type here for readability. Since we're defining a final
  // field, the type is determined at initialization.
//  final HttpClient _httpClient = HttpClient();


  Future<Directory?> getPath() async
  {
     root = await getTemporaryDirectory();
      path = root!.path + '/' + 'a_path';
    return root;
  }

 static CacheOptions cacheOptions =  CacheOptions (
  // Required.
     store: cacheStore,
  policy: CachePolicy.forceCache, // Default. Checks cache freshness, requests otherwise and caches response.
 // hitCacheOnErrorExcept: [401, 403], // Optional. Returns a cached response on error if available but for statuses 401 & 403.
 // priority: CachePriority.normal, // Optional. Default. Allows 3 cache sets and ease cleanup.
  maxStale: const Duration(days: 7), // Very optional. Overrides any HTTP directive to delete entry past this duration.
  );


  static late BuildContext context;
  /// The API endpoint we want to hit.
  ///
  /// This API doesn't have a key but often, APIs do require authentication
  final String _url = 'flk.sa';
  static var uri = "https://flk.sa";
  static var uri2 = "https://flkwatches.flk.sa";
  String? token ;

  static BaseOptions options = BaseOptions(
    baseUrl: uri,
    responseType: ResponseType.plain,
    connectTimeout: 20000,
    receiveTimeout: 20000,
    headers: {"Content-Type": "application/json",
      "Access-Control-Allow-Credentials": true,
      "Authorization":'957|QG8tc6UnNEb71uaZmVFGwo5HCkwhdmwRqCqhP2nV', // sharedPrefs.tokenKey.replaceAll('Bearer','').trim().toString(),

      "Access-Control-Allow-Origin":"*",
  'Charset': 'utf-8',// Required for CORS support to work
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    },
  );
  static BaseOptions optionsPost = BaseOptions(
    baseUrl: uri,
    responseType: ResponseType.json,
    connectTimeout: 20000,
    receiveTimeout: 20000,
    headers: {"Content-Type": "application/json",
      "Access-Control-Allow-Credentials": true,
      "Access-Control-Allow-Origin":"*",
      "Authorization":'957|QG8tc6UnNEb71uaZmVFGwo5HCkwhdmwRqCqhP2nV', // sharedPrefs.tokenKey.replaceAll('Bearer','').trim().toString(),

      'Charset': 'utf-8',// Required for CORS support to work
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST,OPTIONS"
    },
  );
 static late Dio dio ;


  /// Gets all the units and conversion rates for a given category.
  ///
  /// The `category` parameter is the name of the [] from which to
  /// retrieve units. We pass this into the query parameter in the API call.
  ///
  /// Returns a list. Returns null on error.
  /*Future<List> getUnits(String category) async {
    final uri = Uri.https(_url, '/$category');
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['units'] == null) {
      print('Error retrieving units.');
      return null;
    }
    return jsonResponse['units'];
  }*/

  /// Given two units, converts from one to another.
  ///
  /// Returns a double, which is the converted amount. Returns null on error.
  Future<ModelUser?> loginApi(
      String category, String? eMail, String? password) async {
    final String url = uri + '/api/$category';
    final jsonResponse = await _postJson(url, eMail, password);
    if (jsonResponse == null || jsonResponse['message'] != 'success') {
      // print(jsonResponse['message']);

    } else if (jsonResponse['message'] == 'success') {
      print('success' + jsonResponse['message']);
      return ModelUser.fromJson(jsonResponse);
    }

    //  return ModelUser.fromJson(jsonResponse);
    return null;
  }

  Future<ModelAds?> adsApi(String category) async {
    final String url = uri + '/api/$category';
    //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //  final String token = sharedPreferences.getString('tokenKey');
    final jsonResponse = await _getAds(url, sharedPrefs.tokenKey);
    /*  if (jsonResponse == null || jsonResponse['message'] != 'success') {
       print(jsonResponse['message']);

    } else if (jsonResponse['message'] == 'success') {
      print('success' + jsonResponse['message']);
      return ModelAds.fromJson(jsonResponse);
    }*/
    if(jsonResponse != null && jsonResponse['message'].toString().contains('slint'))
    {
      ModelAds modelAds = ModelAds();
      modelAds.path = 'slint';
      return modelAds;
    }
    if(jsonResponse == null)
    {
      ModelAds? modelAds;
      return modelAds;
    }
    //  return ModelUser.fromJson(jsonResponse);
    return ModelAds.fromJson(jsonResponse);
  }

  Future<ModelCats?> catsApi(String category) async {
    final String url = uri + '/api/$category';

    final jsonResponse = await _getCats(url, sharedPrefs.tokenKey);
    if(jsonResponse != null && jsonResponse['message'].toString().contains('slint'))
    {
      ModelCats modelCats = ModelCats();
      modelCats.path = 'slint';
      return modelCats;
    }
if(jsonResponse == null)
{
  ModelCats? modelCats;
  return modelCats;
}
    return ModelCats.fromJson(jsonResponse);
  }

  Future<ModelUser?> registerApi(String category, String? name, String? lName,
      String? eMail, String? password, String? phone, String? address) async {
    final String url = uri + '/api/$category';
    final jsonResponse = await _postJsonRegister(
        url, name, lName, eMail, password, phone, address);
    if (jsonResponse == null || jsonResponse['message'] != 'success') {
      // print(jsonResponse['message']);

      // return null;
    } else if (jsonResponse['message'] == 'success') {
      print('success' + jsonResponse['message']);
      return ModelUser.fromJson(jsonResponse);
    }

    return null;
  }


  Future<Map<String, dynamic>?> _postJson(
      String url, String? eMail, String? password) async {
    try {
      print(eMail);
      print(password);
      print(url);
      Dio dio = Dio(optionsPost);

      Options requestOptions = Options(
        headers: {"Content-Type": "application/json"},
      );

      // try {
      final Map<String, String?> data = {'email': eMail, 'password': password};
      Response response =
          await dio.post(url, data: data, options: requestOptions);
      print('weblogin'+response.toString());

      return json.decode(response.toString());
    } on Exception catch (e) {
      print('execptionnnnnn' + e.toString());

      if (e is DioError) {
        if (e.response.toString().contains('Unauthorized')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).wrongEmailOrPass,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).loginFailed ,S.of(context).wrongEmailOrPass, DialogType.ERROR);
        }
        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).slowInternet,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).loginFailed ,S.of(context).slowInternet, DialogType.ERROR);
          return null;
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            /*Fluttertoast.showToast(
                msg: S.of(context).slowInternet,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: colorPrimary,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM);*/
            MyApplication.getDialogue(context, S.of(context).loginFailed ,S.of(context).slowInternet, DialogType.ERROR);
            return null;
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).loginFailed ,S.of(context).slowInternet, DialogType.ERROR);
          return null;
        }
        // return json.decode(e.response.toString());
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      /*if (e.response != null) {
        print('dataresssss');
        print(e.response);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }*/
    }
  }

  Future<Map<String, dynamic>?> _postJsonRegister(
      String url,
      String? name,
      String? lName,
      String? eMail,
      String? password,
      String? phone,
      String? address) async {
    try {
      print(eMail);
      print(password);
      print(url);
      print(name);
      print(lName);
      print(phone);
      print(address);
      Dio dio = Dio(optionsPost);
      Options requestOptions = Options(
        headers: {"Content-Type": "application/json"},
      );
      final Map<String, String?> data = {
        'first_name': name,
        'last_name': lName,
        'email': eMail,
        'password': password,
        'password_confirmation': password,
        'phone': phone,
        'address': address
      };
      Response response = await dio.post(
        url,
        data: data,
        options: requestOptions,
      );
      return json.decode(response.toString());
    } on Exception catch (e) {
      print('exceptioniggggggggg' + e.toString());
      if (e is DioError) {
        if (e.response
            .toString()
            .contains('The email has already been taken')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).dubEmail,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).registerFailed ,S.of(context).dubEmail, DialogType.ERROR);
        }
        if (e.response.toString().contains('must be at least 7 characters')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).shortPass,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context,S.of(context).registerFailed ,S.of(context).shortPass,  DialogType.ERROR);
        }

        if (e.response
            .toString()
            .contains('The phone has already been taken')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).dubPhone,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).registerFailed,S.of(context).dubPhone,  DialogType.ERROR);
        }
        if (e.response
            .toString()
            .contains('The password confirmation does not match')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).diffPasses,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).registerFailed ,S.of(context).diffPasses,  DialogType.ERROR);
        }
        // return json.decode(e.response.toString());

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).slowInternet,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).registerFailed,S.of(context).slowInternet,  DialogType.ERROR);
          return null;
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            /*Fluttertoast.showToast(
                msg: S.of(context).slowInternet,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: colorPrimary,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM);*/
            MyApplication.getDialogue(context, S.of(context).registerFailed,S.of(context).slowInternet,  DialogType.ERROR);
            return null;
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).registerFailed,S.of(context).slowInternet,  DialogType.ERROR);
          return null;
        }
      }
    }
  }

  Future<Map<String, dynamic>?> _getAds(String url, String token) async {
    try {
    //  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

      Dio dio = Dio(options);

      dio.interceptors.add(DioCacheInterceptor(options:CacheOptions(store: cacheStore,policy: CachePolicy.forceCache)));

      Options requestOptions = Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": token,
              'Charset': 'utf-8'
            },
          );
      Response response = await dio.get(url, options: /*buildCacheOptions(Duration(days: 7), options:*/ requestOptions);
      print('responseAds');
      print(response);
      return json.decode(response.toString())[0];
    }on Exception catch (e) {
      if(e is DioError)
      {

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
         // MyApplication.getDialogue(context, S.of(context).timeOut, '', DialogType.ERROR);

        }
      }
    }
  }

  Future<Map<String, dynamic>?> _getCats(String url, String token) async {
    try {
      print(url + 'url cats');
     // DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

      Dio dio = Dio(options);

   //  dio.interceptors.add(DioCacheInterceptor(options:CacheOptions(store: cacheStore,policy: CachePolicy.forceCache)));

      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization":token, // sharedPrefs.tokenKey.replaceAll('Bearer','').trim().toString(),
          'Charset': 'utf-8'
        },
      );
      print('token cats  '+sharedPrefs.tokenKey.replaceAll('Bearer' ,'').trim().toString());
      Response response = await dio.get(url, options: /*buildCacheOptions(
          Duration(days: 7), options:*/ requestOptions);
      print('responsecats');
      print(response);
      return json.decode(response.toString())[0];
    } on Exception catch(e)
    {
      if(e is DioError)
      {

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          ProviderHome.slowInternetCats = true;
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }

         // MyApplication.getDialogue(context, S.of(context).timeOut, '', DialogType.ERROR);
        }
      }
    }
  }

  productsApi(String category, String? catQuery, String trendQuery,
      String searchQuery) async {
    try {
      final String url = uri +
          '/api/$category?' +
          'search=$searchQuery' +
          '&category=$catQuery' +
          '&trend=$trendQuery';
      final String url2 =
          'https://flkwatches.flk.sa/api/products?search=&category=&trend=';
//String boxName = trendQuery == "1"? dataBoxNameCacheProductsCats:dataBoxNameCacheProducts;
      final jsonResponse = await (_getProducts(url, sharedPrefs.tokenKey));
    //  print(jsonResponse['message'].toString());
      if(jsonResponse != null && jsonResponse['message'].toString().contains('slint'))
      {
        ModelProducts modelProducts = new ModelProducts();
        modelProducts.path = 'slint';
        return modelProducts;
      }

     if (jsonResponse == null && catQuery != '') {
         print('responseeee'+jsonResponse.toString());


          if(! await MyApplication.checkConnection())
          {
            MyApplication.getDialogue(context,S.of(context).couldNotFindResults, S.of(context).noInternet, DialogType.ERROR);
          }
         ModelProducts? modelProducts  =  new ModelProducts();
          return modelProducts;

        }
     else if(jsonResponse == null)
     {
      // return;
     }
    else if( jsonResponse['message'].toString().contains('غير موجود')) {
       ModelProducts modelProducts = ModelProducts();
       modelProducts.data = [];
      return modelProducts;
    }
      return  ModelProducts.fromJson(jsonResponse!);

    } on Exception catch(e)
    {
      print('exceptionnnnnnnnnnn'+e.toString());
      if(e is DioError)
      {
        if(e.response.toString().contains('غير موجود')){
       /*   Fluttertoast.showToast(
              msg: 'name',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          ModelProducts modelProducts = ModelProducts();
          modelProducts.data = [];
          return modelProducts;

          //return modelProducts;

        }

      }
    }
  }

  Future<Map<String, dynamic>?> _getProducts(String url, String token) async {
    try {
     Options requestOptions = Options(

            headers: {"Content-Type": "application/json", "Authorization": token,'Charset': 'utf-8'},

          );
    //  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());


     dio = Dio(options);

     dio.interceptors.add(DioCacheInterceptor(options:CacheOptions(store: cacheStore,policy: CachePolicy.forceCache)));
      Response response = await Api.dio.get(url, options: /*buildCacheOptions(Duration(days: 7), options:*/requestOptions);
     print('respnotfound'+response.toString());

      //if(!await HiveService().isExists(boxName: boxName)) {
      //  HiveService().addBoxes(modelProducts, boxName);
     // }
      print('responseAds');
      print(response);
    //  if(await MyApplication.checkConnection()) {
        return json.decode(response.toString())[0];

     /* else
        {
          List<ModelProducts> models = [];
          ModelProducts modelProducts = new ModelProducts();
          modelProducts.data = HiveService().getBoxes(boxName) as List<Datum>;
          models.add(modelProducts);
          return json.decode(modelProductsToJson(models).toString())[0];

        }*/
    }on Exception catch (e) {

    //  print('exceptionnnnnnnnnnn44'+e.toString());
      if(e is DioError)
      {
        print('exceptionnnnnnnnnnn44'+jsonDecode(e.response.toString()).toString());
        if(jsonDecode(e.response.toString()).toString().contains('غير موجود'))
        {
         // print('hhhhhhhhhhhhhhhhhhhhhhhhhhhh');
          return jsonDecode(e.response.toString()) ;
        }
        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          ProviderHome.slowInternetPros = true;
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
            /*   Fluttertoast.showToast(
              msg: S.of(context).slowInternet,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
        /*  }
          else
            {
              List<ModelProducts> models = [];
              ModelProducts modelProducts = new ModelProducts();
              modelProducts.data = await HiveService().getBoxes(boxName);
              models.add(modelProducts);
              return json.decode(modelProductsToJson(models).toString())[0];
            }*/
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }

        }


      }
    }
  }

  Future<ModelUser?> passWordResetApi(String category, String? password) async {
    final String url = uri + '/api/$category';
    final jsonResponse =
        await (_postPassWordJson(url, password, sharedPrefs.tokenKey));
  //  print(jsonResponse['message'].toString());
    if (jsonResponse == null ||
        jsonResponse['message'] != 'تم تحديث كلمة المرور') {
      // print(jsonResponse['message']);

    } else if (jsonResponse['message'] == 'تم تحديث كلمة المرور') {
      print('success' + jsonResponse['message']);
      return ModelUser.fromJson(jsonResponse);
    }

    //  return ModelUser.fromJson(jsonResponse);
    return null;
  }

  Future<Map<String, dynamic>?> _postPassWordJson(
      String url, String? password, String token) async {
    try {
      print(password);
      print(url);
      Dio dio = Dio(optionsPost);
      Options requestOptions = Options(
        headers: {"Content-Type": "application/json", "Authorization": token},
      );
      // try {
      final Map<String, String?> data = {
        'password_confirmation': password,
        'password': password
      };
      Response response =
          await dio.post(url, data: data, options: requestOptions);
      print(response.data);

      return json.decode(response.toString());
    } on Exception catch (e) {
      print('execptionnnnnn' + e.toString());

      if (e is DioError) {
        print('dio error' + e.response.toString());
        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).slowInternet,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).passwordResetFailed ,S.of(context).slowInternet,  DialogType.ERROR);
          return null;
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {

          if (await MyApplication.checkConnection()) {
            /*Fluttertoast.showToast(
                msg: S.of(context).slowInternet,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: colorPrimary,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM);*/
            MyApplication.getDialogue(context, S.of(context).passwordResetFailed ,S.of(context).slowInternet,  DialogType.ERROR);
            return null;
          }

        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).passwordResetFailed ,S.of(context).slowInternet,  DialogType.ERROR);
          return null;
        }
        // return json.decode(e.response.toString());
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      /*if (e.response != null) {
        print('dataresssss');
        print(e.response);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }*/
    }
  }

  Future<ModelUser?> updateProfileApi(String category, String? name, String? lName,
      String? eMail, String? phone, String? address) async {
    final String url = uri + '/api/$category';
    final jsonResponse = await (_postJsonProfile(
        url, name, lName, eMail, phone, address, sharedPrefs.tokenKey));
   // print(jsonResponse == null?null:jsonResponse['message'].toString());
    if (jsonResponse == null || jsonResponse['message'].toString() != 'تم تحديث الملف الشخصي بنجاح') {
      // print(jsonResponse['message']);

      // return null;
    } else if (jsonResponse['message'].toString() == 'تم تحديث الملف الشخصي بنجاح') {
      print('success' + jsonResponse['message']);
      return ModelUser.fromJson(jsonResponse);
    }
    return null;
  }

  Future<Map<String, dynamic>?> _postJsonProfile(
      String url,
      String? name,
      String? lName,
      String? eMail,
      String? phone,
      String? address,
      String token) async {
    try {
      print(eMail);
      print(S.of(context).password);
      print(url);
      print(name);
      print(lName);
      print(phone);
      print(address);
      Dio dio = Dio(optionsPost);
      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          'Charset': 'utf-8'
        },
      );
      final Map<String, String?> data = {
        'first_name': name,
        'last_name': lName,
        'email': eMail,
        'phone': phone,
        'address': address
      };
      Response response = await dio.post(
        url,
        data: data,
        options: requestOptions,
      );
      return json.decode(response.toString());
    } on Exception catch (e) {
      print('exceptioniggggggggg' + e.toString());
      if (e is DioError) {
        print('exceptioniggggggggg' + e.response.toString());
        if (e.response
            .toString()
            .contains('The email has already been taken')) {
         /* Fluttertoast.showToast(
              msg: S.of(context).dubEmail,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).profileUpdateFailed ,S.of(context).dubEmail,  DialogType.ERROR);
        }
        if (e.response.toString().contains('must be at least 7 characters')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).shortPass,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).profileUpdateFailed,S.of(context).shortPass, DialogType.ERROR);
        }

        if (e.response
            .toString()
            .contains('The phone has already been taken')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).dubPhone,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).profileUpdateFailed,S.of(context).dubPhone,  DialogType.ERROR);
        }
        if (e.response
            .toString()
            .contains('The password confirmation does not match')) {
         /* Fluttertoast.showToast(
              msg: S.of(context).diffPasses,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).profileUpdateFailed,S.of(context).diffPasses, DialogType.ERROR);
        }
        // return json.decode(e.response.toString());

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).slowInternet,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).profileUpdateFailed,S.of(context).slowInternet, DialogType.ERROR);
          return null;
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {

          if (await MyApplication.checkConnection()) {
            /*Fluttertoast.showToast(
                msg: S.of(context).slowInternet,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: colorPrimary,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM);*/
            MyApplication.getDialogue(context, S.of(context).profileUpdateFailed,S.of(context).slowInternet, DialogType.ERROR);
            return null;
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).profileUpdateFailed,S.of(context).slowInternet, DialogType.ERROR);
          return null;
        }
      }
    }
  }
  Future<ModelUser?> getUserApi(String category) async {
    final String url = uri + '/api/$category';
    //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //  final String token = sharedPreferences.getString('tokenKey');
    final jsonResponse = await _getUser(url, sharedPrefs.tokenKey);
    /*  if (jsonResponse == null || jsonResponse['message'] != 'success') {
       print(jsonResponse['message']);

    } else if (jsonResponse['message'] == 'success') {
      print('success' + jsonResponse['message']);
      return ModelAds.fromJson(jsonResponse);
    }*/
    if(jsonResponse != null && jsonResponse['message'].toString().contains('slint'))
    {
      ModelUser modelUser = ModelUser();
      modelUser.message = 'slint';
      return modelUser;
    }
    if(jsonResponse == null)
    {
      ModelUser? modelUser;
      return modelUser;
    }
    //  return ModelUser.fromJson(jsonResponse);
    return ModelUser.fromJson(jsonResponse);
  }
  Future<Map<String, dynamic>?> _getUser(String url, String token) async {
    try {
   //   DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

      Dio dio = Dio(options);
    // dio.interceptors.add(DioCacheInterceptor(options:CacheOptions(store: cacheStore,policy: CachePolicy.forceCache)));
    
      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          'Charset': 'utf-8'
        },
      );
      Response response = await dio.get(url, options: requestOptions);
      print('responseAds');
      print(response);
      return json.decode(response.toString());
    }on Exception catch (e) {
      if(e is DioError)
      {

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }

        }



          // return json.decode(e.response.toString());


          if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
            if(await MyApplication.checkConnection()) {
              if (await MyApplication.checkConnection()) {
                return jsonDecode('{' +
                    '"message": "slint"' +
                    '}');
              }
            }
          }
        }
      }

  }
  Future<ModelGoverns?> getGovsApi(String category) async {
    final String url = uri + '/api/$category';
    //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //  final String token = sharedPreferences.getString('tokenKey');
    final jsonResponse = await _getGovs(url, sharedPrefs.tokenKey);
    /*  if (jsonResponse == null || jsonResponse['message'] != 'success') {
       print(jsonResponse['message']);

    } else if (jsonResponse['message'] == 'success') {
      print('success' + jsonResponse['message']);
      return ModelAds.fromJson(jsonResponse);
    }*/
    if(jsonResponse != null && jsonResponse['message'].toString().contains('slint'))
    {
      ModelGoverns modelGoverns = ModelGoverns();
      modelGoverns.name = 'slint';
      return modelGoverns;
    }
    if(jsonResponse == null)
    {
      ModelGoverns? modelGoverns;
      return modelGoverns;
    }
    //  return ModelUser.fromJson(jsonResponse);
    return ModelGoverns.fromJson(jsonResponse);
  }
  Future<Map<String, dynamic>?> _getGovs(String url, String token) async {
    try {
     // DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

      Dio dio = Dio(options);
   //  dio.interceptors.add(DioCacheInterceptor(options:CacheOptions(store: cacheStore,policy: CachePolicy.forceCache)));
    
      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          'Charset': 'utf-8'
        },
      );
      final Map<String, String> data = {'name': 'مصر'};
      Response response = await dio.post(url, data: data ,options: requestOptions);
      print('responseAds');
      print(response);
      return json.decode(response.toString())[0];
    }on Exception catch (e) {
      if(e is DioError)
      {

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }



        // return json.decode(e.response.toString());


        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
      }
    }

  }
  Future<ModelOrders?> getOrdersApi(String category) async {
    final String url = uri + '/api/$category';
    //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //  final String token = sharedPreferences.getString('tokenKey');
    final jsonResponse = await _getOrders(url, sharedPrefs.tokenKey);
    /*  if (jsonResponse == null || jsonResponse['message'] != 'success') {
       print(jsonResponse['message']);

    } else if (jsonResponse['message'] == 'success') {
      print('success' + jsonResponse['message']);
      return ModelAds.fromJson(jsonResponse);
    }*/
    if(jsonResponse != null && jsonResponse['message'].toString().contains('slint'))
    {
      ModelOrders modelOrders = ModelOrders();
      modelOrders.path = 'slint';
      return modelOrders;
    }
    if(jsonResponse == null)
    {
      ModelOrders? modelOrders;
      return modelOrders;
    }
    //  return ModelUser.fromJson(jsonResponse);
    return ModelOrders.fromJson(jsonResponse);
  }
  Future<Map<String, dynamic>?> _getOrders(String url, String token) async {
    try {
     // DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

      Dio dio = Dio(options);
     dio.interceptors.add(DioCacheInterceptor(options:CacheOptions(store: cacheStore,policy: CachePolicy.forceCache)));
    
      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          'Charset': 'utf-8'
        },
      );

      Response response = await dio.get(url,options:/*buildCacheOptions(Duration(days: 7), options:*/ requestOptions);
      print('responseAds');
      print(response);
      return json.decode(response.toString());
    }on Exception catch (e) {
      if(e is DioError)
      {
        print('ggggggggggggg'+e.response.toString());

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }



        // return json.decode(e.response.toString());


        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
      }
    }

  }
  Future<String?> orderRequestApi(
      String category, Map<String, Object?> data) async {
    final String url = uri + '/api/$category';
    final  jsonResponse = await _postOrderRequestJson(url, data);
   // if (jsonResponse == null || jsonResponse['success'] != 'true') {
      // print(jsonResponse['message']);
    print('dataorder3'+ jsonResponse.toString());
    if(jsonResponse == null)
    {

    }
     else if(jsonResponse['success'].toString() == 'false')
      {
        print('succcccccc+falseeeeeeee');
        MyApplication.getDialogue2(context, S.of(context).orderRequestFailed,S.of(context).productNAvail, DialogType.ERROR);
        return 'f';
     // }

    } else if (jsonResponse['success'].toString() == 'true') {
      print('successssssssss');
      MyApplication.getDialogue2(context, S.of(context).orderedSuccessfully , S.of(context).orderPlaced, DialogType.SUCCES);
      return 's';
    }

    //  return ModelUser.fromJson(jsonResponse);
    return null;
  }
  Future<Map<String, dynamic>?> _postOrderRequestJson(
      String url, Map<String, Object?> data) async {
    try {

      Dio dio = Dio(optionsPost);
      print('dataorderyyyyy'+ json.encode(data));
      Options requestOptions = Options(
        headers: {"Content-Type": "application/json","Authorization": sharedPrefs.tokenKey,
      },
      );
    //  print('dataorder4'+ data.toString());
      // try {
      /*final Map<String, Object> data = {
        "first_name":"Fady",
        "last_name" : "Mondy",
        "phone": "01069706892",
        "email": "engfadymondy@gmail.com",
        "address": "Elhoda Mosque St, Hod Eltawel, Elsalam Owel, Cairo, Egypt",
        "gov_id": 1,
        "city_id" : 1,
        "cart": [
          {
            "product_id": 1,
            "qnt": 1,
            "price": 250,
            "discount": 0,
            "options": [
              "احمر",
              "m"
            ]
          }
        ],
        "payment": "cash",
        "shipped": 35,
        "total": 285
      };*/
      Response response =
      await dio.post(url, data: data, options: requestOptions);

      print(response.data);

      return json.decode(response.toString());
    } on Exception catch (e) {
      print('execptionnnnnn' + e.toString());

      if (e is DioError) {

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).slowInternet,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).orderRequestFailed,S.of(context).slowInternet, DialogType.ERROR);
          return null;
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            /*Fluttertoast.showToast(
                msg: S.of(context).slowInternet,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: colorPrimary,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM);*/
            MyApplication.getDialogue(context, S.of(context).orderRequestFailed,S.of(context).slowInternet, DialogType.ERROR);
            return null;
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).orderRequestFailed,S.of(context).slowInternet, DialogType.ERROR);
          return null;
        }
        // return json.decode(e.response.toString());
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      /*if (e.response != null) {
        print('dataresssss');
        print(e.response);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }*/
    }
  }
  Future<String?> inventoryCheckApi(
      String category,Map<String,Object?> data) async {
    print('dataaaaaaaaaaa'+data.toString());
    final String url = uri + '/api/$category';
    final jsonResponse = await _postInventoryJson(url,data );

    if(jsonResponse == null)
    {

    }

   else if(jsonResponse['success'].toString() == 'false' || jsonResponse['check'].toString() == 'null' || jsonResponse['check'].toString() == 'false' )
    {
      print('succcccccc+falseeeeeeee');
      MyApplication.getDialogue(context, S.of(context).addingFailed,S.of(context).productNAvail, DialogType.ERROR);
      // }
        return 'f';
    } else if (jsonResponse['success'].toString() == 'true' && jsonResponse['check'].toString() == 'true') {
      print('successssssssss');
      MyApplication.getDialogue(context, S.of(context).addedSuccessfully , S.of(context).productAddTCart, DialogType.SUCCES);
      return 's';
    }

    //  return ModelUser.fromJson(jsonResponse);
    return null;
  }
  Future<Map<String, dynamic>?> _postInventoryJson(
      String url, Map<String, Object?> data) async {
    try {

      Dio dio = Dio(optionsPost);

      Options requestOptions = Options(
        headers: {"Content-Type": "application/json","Authorization": sharedPrefs.tokenKey,
          'Charset': 'utf-8'},
      );

      // try {
     /* ;*/
      Response response =
      await dio.post(url, data: data, options: requestOptions);
    //  print('hhhhhhhhhhhhhhhhhh'+response.data);

      return json.decode(response.toString());
    } on Exception catch (e) {
      print('execptionnnnnn' + e.toString());

      if (e is DioError) {

        if (e.error
            .toString()
            .contains('No address associated with hostname')) {
          /*Fluttertoast.showToast(
              msg: S.of(context).slowInternet,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).addingFailed,S.of(context).slowInternet, DialogType.ERROR);
          return null;
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {
          
          if (await MyApplication.checkConnection()) {
            /*Fluttertoast.showToast(
                msg: S.of(context).slowInternet,
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: colorPrimary,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM);*/
            MyApplication.getDialogue(context, S.of(context).addingFailed,S.of(context).slowInternet,  DialogType.ERROR);
            return null;
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          MyApplication.getDialogue(context, S.of(context).addingFailed,S.of(context).slowInternet,  DialogType.ERROR);
          return null;
        }
        // return json.decode(e.response.toString());
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      /*if (e.response != null) {
        print('dataresssss');
        print(e.response);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }*/
    }
  }
  Future<ModelSetting?> settingsApi(
      String category, String? key) async {
    final String url = uri + '/api/$category';
    final jsonResponse = await _postJsonSettings(url, key);
    if(jsonResponse != null && jsonResponse['message'].toString().contains('slint'))
    {
      ModelSetting modelSetting = ModelSetting();
      modelSetting.path = 'slint';
      return modelSetting;
    }
    if(jsonResponse == null)
    {
      print('nulllllprice');
      ModelSetting? modelSetting;
      return modelSetting;
    }
      return ModelSetting.fromJson(jsonResponse);


    //  return ModelUser.fromJson(jsonResponse);

  }
  Future<Map<String, dynamic>?> _postJsonSettings(
      String url, String? key) async {
    try {
      print(key);
      print(url);
      Dio dio = Dio(options);
      dio.interceptors.add(DioCacheInterceptor(options:CacheOptions(store: cacheStore,policy: CachePolicy.forceCache)));

      Options requestOptions = Options(
        headers: {"Content-Type": "application/json",'Charset': 'utf-8'},
      );

      // try {
      final Map<String, String?> data = {'key': key,'api': 'FlkSa@2020'};
      print(data.toString()+ 'dataprice');
      Response response =
      await dio.post(url, data: data, options: requestOptions);
      print('websettingres'+response.toString());

      return json.decode(response.toString())[0];
    } on Exception catch (e) {
      print('execptionnnnnn' + e.toString());

      if (e is DioError) {
        print('execptionnnnnnprice' + e.error.toString());
        if (e.error
            .toString()
            .contains('No address associated with hostname')) {

          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (e.error
            .toString()
            .contains('Network is unreachable')) {

          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
        }
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type ||
            DioErrorType.other == e.type) {
          if (await MyApplication.checkConnection()) {
            return jsonDecode('{' +
                '"message": "slint"' +
                '}');
          }
          /*Fluttertoast.showToast(
              msg: S.of(context).timeOut,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: colorPrimary,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM);*/
          // MyApplication.getDialogue(context, S.of(context).timeOut, '', DialogType.ERROR);

        }
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      /*if (e.response != null) {
        print('dataresssss');
        print(e.response);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }*/
    }
  }

}
