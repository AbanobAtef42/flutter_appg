import 'package:flutter/widgets.dart';
import 'package:flutter_app8/models/ModelSetting.dart';
import 'package:flutter_app8/models/ModelsGoverns.dart';
import 'package:flutter_app8/models/modelUser.dart';
import 'package:flutter_app8/values/api.dart';

class ProviderUser with ChangeNotifier
{
  ModelUser? modelUser = new ModelUser();
  ModelUser? modelUser2 = new ModelUser();
  ModelUser? modelUserPass = new ModelUser();
  ModelUser? modelUserProfile = new ModelUser();
  ModelGoverns? modelGoverns = new ModelGoverns();
  bool loading = false;
  bool loadingReg = false;
 static String? name, lName, eMail, password, phone, address , settingKey;

  ModelSetting? modelSettings;



  getPostLoginData(context) async {

    final Api api = Api();
    modelUser = await api.loginApi("login", eMail, password);


    notifyListeners();
  }
  getPostRegisterData(context) async {

    final Api api = Api();
    modelUser2 = await api.registerApi("register",name,lName, eMail, password,phone,address);


    notifyListeners();
  }
  getPostPassWordData(context) async {

    final Api api = Api();
    modelUserPass = await api.passWordResetApi("profile/password", password);


    notifyListeners();
  }
  getPostProfileData(context) async {

    final Api api = Api();
    modelUserProfile = await api.updateProfileApi("profile",name,lName,eMail,phone,address);


    notifyListeners();
  }
  getUserData(context) async {

    final Api api = Api();
    modelUser = await api.getUserApi("user");


    notifyListeners();
  }
  getGovsData(context) async {

    final Api api = Api();
    modelGoverns = await api.getGovsApi("locations");


    notifyListeners();
  }
  getSettingsData() async {

    final Api api = Api();
    modelSettings = await api.settingsApi("settings",settingKey);
   // print(modelSettings!.data.toString()+'provider price');


    notifyListeners();
  }
}