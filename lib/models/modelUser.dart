import 'package:hive/hive.dart';
part 'modelUser.g.dart';
class ModelUser {
  String? message;
  User? user;
  String? token;

  ModelUser({this.message, this.user, this.token});

  ModelUser.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}
@HiveType(typeId: 3)
class User {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? countyId;
  @HiveField(7)
  String? govId;
  @HiveField(8)
  String? cityId;
  @HiveField(9)
  String? info;
  @HiveField(10)
  int? login;
  @HiveField(11)
  String? deletedAt;
  @HiveField(12)
  String? createdAt;
  @HiveField(13)
  String? updatedAt;
  @HiveField(14)
  String? fullName;
  @HiveField(15)
  String? resourceUrl;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.address,
        this.countyId,
        this.govId,
        this.cityId,
        this.info,
        this.login,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.fullName,
        this.resourceUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    countyId = json['county_id'];
    govId = json['gov_id'];
    cityId = json['city_id'];
    info = json['info'];
    login = json['login'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    resourceUrl = json['resource_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['county_id'] = this.countyId;
    data['gov_id'] = this.govId;
    data['city_id'] = this.cityId;
    data['info'] = this.info;
    data['login'] = this.login;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['resource_url'] = this.resourceUrl;
    return data;
  }
}