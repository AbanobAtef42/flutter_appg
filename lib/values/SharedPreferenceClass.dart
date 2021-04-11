import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? sharedPrefs;
  factory SharedPrefs() => SharedPrefs._internal();
  SharedPrefs._internal();
  Future<void> init() async {
    sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get tokenKey => sharedPrefs!.getString(keyToken) ?? "";
  String get nameKey => sharedPrefs!.getString(keyName)?? "";
  String get mailKey => sharedPrefs!.getString(keyMail) ?? "";
  String get passKey => sharedPrefs!.getString(keyPass) ?? "";
  String get priceUnitKey => sharedPrefs!.getString(keyPriceUnit) ?? "";
  String get exertedPriceUnitKey => sharedPrefs!.getString(keyExertedPriceUnit) ?? "";
  String get getCurrentUserId => sharedPrefs!.getString(keyCurrentUserId) ?? "";

  set token2(String value) {
    sharedPrefs!.setString(keyToken, value);
  }

  void token(String token) {
    sharedPrefs!.setString(keyToken, token);
  }
  void name(String name) {
    sharedPrefs!.setString(keyName, name);
  }
  void eMail(String mail) {
    sharedPrefs!.setString(keyMail, mail);
  }
  void pass(String pass) {
    sharedPrefs!.setString(keyPass, pass);
  }
  void currentUserId(String id) {
    sharedPrefs!.setString(keyCurrentUserId, id);
  }
  void priceUnit(String unit) {
    sharedPrefs!.setString(keyPriceUnit, unit);
  }
  void exertedPriceUnit(String unit) {
    sharedPrefs!.setString(keyExertedPriceUnit, unit);
  }
}

final sharedPrefs =  SharedPrefs();
// constants/strings.dart
const String keyToken = "key_token";
const String keyPriceUnit = "key_price_unit";
const String keyExertedPriceUnit = "key_exerted_price_unit";
const String keyName = "key_name";
const String keyPass = "key_pass";
const String keyMail = "key_email";
const String keyLang = "key_lang";
const String keyCurrentUserId = "key_current_user_id";