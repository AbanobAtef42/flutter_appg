// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `This Field Is Required`
  String get emptyField {
    return Intl.message(
      'This Field Is Required',
      name: 'emptyField',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternet {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed\nWrong Email Or Password`
  String get wrongEmailOrPass {
    return Intl.message(
      'Login Failed\nWrong Email Or Password',
      name: 'wrongEmailOrPass',
      desc: '',
      args: [],
    );
  }

  /// `An Error Occured\nTime out`
  String get timeOut {
    return Intl.message(
      'An Error Occured\nTime out',
      name: 'timeOut',
      desc: '',
      args: [],
    );
  }

  /// `Slow Internet Connection`
  String get slowInternet {
    return Intl.message(
      'Slow Internet Connection',
      name: 'slowInternet',
      desc: '',
      args: [],
    );
  }

  /// `Register Failed\nThe email has already been taken`
  String get dubEmail {
    return Intl.message(
      'Register Failed\nThe email has already been taken',
      name: 'dubEmail',
      desc: '',
      args: [],
    );
  }

  /// `Register Failed\nPassword must be at least 7 characters`
  String get shortPass {
    return Intl.message(
      'Register Failed\nPassword must be at least 7 characters',
      name: 'shortPass',
      desc: '',
      args: [],
    );
  }

  /// `Register Failed\nThe phone has already been taken`
  String get dubPhone {
    return Intl.message(
      'Register Failed\nThe phone has already been taken',
      name: 'dubPhone',
      desc: '',
      args: [],
    );
  }

  /// `Register Failed\nThe password confirmation does not match`
  String get diffPasses {
    return Intl.message(
      'Register Failed\nThe password confirmation does not match',
      name: 'diffPasses',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lName {
    return Intl.message(
      'Last Name',
      name: 'lName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `SignedIn Successfully`
  String get signed {
    return Intl.message(
      'SignedIn Successfully',
      name: 'signed',
      desc: '',
      args: [],
    );
  }

  /// `Your Password Update Success`
  String get PassUpdated {
    return Intl.message(
      'Your Password Update Success',
      name: 'PassUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile Update Success`
  String get profileUpdated {
    return Intl.message(
      'Your Profile Update Success',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Login To Your Account`
  String get loginLabel {
    return Intl.message(
      'Login To Your Account',
      name: 'loginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit PassWord`
  String get editPass {
    return Intl.message(
      'Edit PassWord',
      name: 'editPass',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile Data`
  String get editProfile {
    return Intl.message(
      'Edit Profile Data',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Register Your Account`
  String get registerLabel {
    return Intl.message(
      'Register Your Account',
      name: 'registerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get cartAdd {
    return Intl.message(
      'Add To Cart',
      name: 'cartAdd',
      desc: '',
      args: [],
    );
  }

  /// `Start Shopping`
  String get stShopping {
    return Intl.message(
      'Start Shopping',
      name: 'stShopping',
      desc: '',
      args: [],
    );
  }

  /// `Swipe To Browse`
  String get swiToBrw {
    return Intl.message(
      'Swipe To Browse',
      name: 'swiToBrw',
      desc: '',
      args: [],
    );
  }

  /// `Start your Shopping Experience By \n following All Brands`
  String get stShopDesc {
    return Intl.message(
      'Start your Shopping Experience By \n following All Brands',
      name: 'stShopDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please Fill In the required Fields`
  String get fillIn {
    return Intl.message(
      'Please Fill In the required Fields',
      name: 'fillIn',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get cats {
    return Intl.message(
      'Categories',
      name: 'cats',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get checkOut {
    return Intl.message(
      'Place Order',
      name: 'checkOut',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `quantity`
  String get quantity {
    return Intl.message(
      'quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get governorate {
    return Intl.message(
      'Governorate',
      name: 'governorate',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Shipper`
  String get shipper {
    return Intl.message(
      'Shipper',
      name: 'shipper',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get perData {
    return Intl.message(
      'Personal Data',
      name: 'perData',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment {
    return Intl.message(
      'Payment Method',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `WishList`
  String get wish {
    return Intl.message(
      'WishList',
      name: 'wish',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have Account?`
  String get notRegistered {
    return Intl.message(
      'Don\'t Have Account?',
      name: 'notRegistered',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get signupnow {
    return Intl.message(
      'SignUp',
      name: 'signupnow',
      desc: '',
      args: [],
    );
  }

  /// `Delete From Cart`
  String get delFCart {
    return Intl.message(
      'Delete From Cart',
      name: 'delFCart',
      desc: '',
      args: [],
    );
  }

  /// `No Products In Wish list`
  String get noProInWishList {
    return Intl.message(
      'No Products In Wish list',
      name: 'noProInWishList',
      desc: '',
      args: [],
    );
  }

  /// `No Products In Shopping Cart`
  String get noProShoppingCart {
    return Intl.message(
      'No Products In Shopping Cart',
      name: 'noProShoppingCart',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favs {
    return Intl.message(
      'Favourites',
      name: 'favs',
      desc: '',
      args: [],
    );
  }

  /// `Ordered At`
  String get orderedAt {
    return Intl.message(
      'Ordered At',
      name: 'orderedAt',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get checkOutBtn {
    return Intl.message(
      'Check Out',
      name: 'checkOutBtn',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get bestSeller {
    return Intl.message(
      'Best Seller',
      name: 'bestSeller',
      desc: '',
      args: [],
    );
  }

  /// `Product Not Available`
  String get productNAvail {
    return Intl.message(
      'Product Not Available',
      name: 'productNAvail',
      desc: '',
      args: [],
    );
  }

  /// `Added Successfully To Cart`
  String get addedSuccessfullyToCart {
    return Intl.message(
      'Added Successfully To Cart',
      name: 'addedSuccessfullyToCart',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Exit?`
  String get exit {
    return Intl.message(
      'Exit?',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Order Failed`
  String get orderFailed {
    return Intl.message(
      'Order Failed',
      name: 'orderFailed',
      desc: '',
      args: [],
    );
  }

  /// `Ordered Successfully`
  String get orderedSuccessfully {
    return Intl.message(
      'Ordered Successfully',
      name: 'orderedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your Order Has Been Placed`
  String get orderPlaced {
    return Intl.message(
      'Your Order Has Been Placed',
      name: 'orderPlaced',
      desc: '',
      args: [],
    );
  }

  /// `Adding Failed`
  String get addingFailed {
    return Intl.message(
      'Adding Failed',
      name: 'addingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Added Successfully`
  String get addedSuccessfully {
    return Intl.message(
      'Added Successfully',
      name: 'addedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Product Has Been Added To Cart`
  String get productAddTCart {
    return Intl.message(
      'Product Has Been Added To Cart',
      name: 'productAddTCart',
      desc: '',
      args: [],
    );
  }

  /// `No Results Found`
  String get noResults {
    return Intl.message(
      'No Results Found',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Registered Successfully`
  String get registered {
    return Intl.message(
      'Registered Successfully',
      name: 'registered',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}