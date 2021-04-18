import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:flutter_app8/bottom_nav_routes/Account.dart';
import 'package:flutter_app8/bottom_nav_routes/Categories.dart';
import 'package:flutter_app8/models/ModelProducts.dart';
import 'package:flutter_app8/models/modelUser.dart';
import 'package:flutter_app8/providers/providerHome.dart';
import 'package:flutter_app8/providers/providerLanguage.dart';
import 'package:flutter_app8/providers/providerUser.dart';
import 'package:flutter_app8/screens/BottomNavScreen.dart';
import 'package:flutter_app8/screens/CheckoutScreen.dart';
import 'package:flutter_app8/screens/RegisterScreen.dart';
import 'package:flutter_app8/screens/StartShoppingScreen.dart';
import 'package:flutter_app8/screens/loginScreen.dart';
import 'package:flutter_app8/screens/splashScreen.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/api.dart';
import 'package:flutter_app8/values/myApplication.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:uni_links2/uni_links.dart';


import 'bottom_nav_routes/Home.dart';
import 'generated/l10n.dart';
import 'dart:io';
import 'dart:async';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 //await MyApplication.initCache();
  await SharedPrefs().init();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  if(kIsWeb){

  }
  else
    {
      final document = await getApplicationDocumentsDirectory();
      Hive..init(document.path);
    }

  Hive..registerAdapter(DatumAdapter());
  Hive..registerAdapter(VarAdapter());
  Hive..registerAdapter(ValueAdapter());
 // Hive..registerAdapter(UserAdapter());
  await Hive.openBox<Datum>(dataBoxName);
  await Hive.openBox<Datum>(dataBoxNameFavs);
 // await Hive.openBox<Datum>(dataBoxNameUser);
  await Hive.openBox<Datum>(dataBoxNameCacheProductsCats);
  await Hive.openBox<Datum>(dataBoxNameCacheProducts);
  runApp(
  /*DevicePreview(
    enabled: true,
    builder: (context) =>*/ MyApp(
      appLanguage: appLanguage,
    ), // Wrap your app
  );
 // );


}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ProviderUser>(create: (_) => ProviderUser()),
  ChangeNotifierProvider<ProviderHome>(create: (_) => ProviderHome()),
  ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
];

class MyApp extends StatefulWidget {
  final AppLanguage? appLanguage;

  MyApp({this.appLanguage});

  static void setLocale(BuildContext context, Locale locale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  bool first = true;
  late CacheStore cacheStore;
  String? _latestLink;
  String? _initialLink;
  Uri? _initialUri;

  Uri? _latestUri;

  StreamSubscription? _sub;


  changeLanguage(Locale locale) {
    setState(() {
      this.locale = locale;
      first = false;
    });
  }
  @override
  void initState() {
    if(!kIsWeb) {
      getApplicationDocumentsDirectory().then((dir) {
        cacheStore = DbCacheStore(databasePath: dir.path, logStatements: true);

        Api.cacheStore = cacheStore;
      });
    }else {
      cacheStore = DbCacheStore(databasePath: 'db', logStatements: true);
      Api.cacheStore = cacheStore;
    }// cacheStore = FileCacheStore(dir.path);
    super.initState();
    initPlatformStateForStringUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    print(_latestLink.toString());
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => widget.appLanguage!,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          if (first) {
            locale = model.appLocal;
          }
          return MultiProvider(
              providers: providers,
              child: OverlaySupport(

                child: MaterialApp(

                   /*   maxWidth: 1200,
                      minWidth: 480,
                      defaultScale: true,
                      breakpoints: [
                        ResponsiveBreakpoint.resize(480, name: MOBILE),
                        ResponsiveBreakpoint.autoScale(800, name: TABLET),
                        ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                      ],*/

                  builder: (context, widget) =>ResponsiveWrapper.builder(BouncingScrollWrapper.builder(context, widget!),

                    maxWidth: 1200,
                    minWidth: 480,
                    defaultScale: true,
                    breakpoints: [
                      ResponsiveBreakpoint.resize(450, name: MOBILE),
                    //  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                      ResponsiveBreakpoint.resize(1000, name: TABLET),
                      ResponsiveBreakpoint.autoScaleDown(1200, name: DESKTOP,scaleFactor: 0.4),
                      ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                    ],


                  ),

                  initialRoute: _latestLink == null ? SplashScreen.name : BottomNavHost.name,

                  locale: locale,
                  localizationsDelegates: [
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    S.delegate,
                  ],
                  supportedLocales: [
                    Locale("en", "US"),
                    Locale(
                        "ar", ""), // OR Locale('ar', 'AE') OR Other RTL locales
                  ],
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    
                     primarySwatch: generateMaterialColor(colorPrimary),
                    primaryColor: colorPrimary,
                    accentColor: Colors.white,
                    highlightColor: colorPrimary,
                    fontFamily: 'Georgia',
                    buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme
                          .primary, //  <-- this auto selects the right color
                    ),
                    textTheme: TextTheme(
                      headline1: TextStyle(
                          fontSize: 72.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia'),
                      headline2: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia'),
                      headline3: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Georgia',
                          height: 2),
                      headline4: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Georgia'),
                      headline6: TextStyle(
                          fontSize: 36.0, fontStyle: FontStyle.italic),
                      headline5: TextStyle(
                          fontStyle: FontStyle.italic, fontFamily: 'Georgia'),
                      bodyText2:
                          TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: colorPrimary,
                      selectionColor: colorPrimary,
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                  home: _latestLink == null ? SplashScreen() : BottomNavHost(_latestLink!.replaceAll('https://foryou.flk.sa/store/', '')),
                ),
              ),
          );
        })
    );
  }
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
  Future<void> initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    if (!kIsWeb)
      _sub = linkStream.listen((String? link) {
        if (!mounted) return;
        setState(() {
          _latestLink = link ?? 'Unknown';
          _latestUri = null;
          try {
            if (link != null) _latestUri = Uri.parse(link);
          } on FormatException {}
        });
      }, onError: (Object err) {
        if (!mounted) return;
        setState(() {
          _latestLink = 'Failed to get latest link: $err.';
          _latestUri = null;
        });
      });

    // Attach a second listener to the stream
    if (!kIsWeb)
      linkStream.listen((String? link) {
        print('got link: $link');
      }, onError: (Object err) {
        print('got err: $err');
      });

    // Get the latest link
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _initialLink = await getInitialLink();
      print('initial link: $_initialLink');
      if (_initialLink != null) _initialUri = Uri.parse(_initialLink!);
    } on PlatformException {
      _initialLink = 'Failed to get initial link.';
      _initialUri = null;
    } on FormatException {
      _initialLink = 'Failed to parse the initial link as Uri.';
      _initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestLink = _initialLink;
      _latestUri = _initialUri;
    });
  }
  /*initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri? initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri.toString();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });
  }*/
}
