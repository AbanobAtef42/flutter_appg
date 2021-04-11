// To parse this JSON data, do
//
//     final modelGoverns = modelGovernsFromJson(jsonString);

import 'dart:convert';

List<ModelGoverns> modelGovernsFromJson(String str) => List<ModelGoverns>.from(json.decode(str).map((x) => ModelGoverns.fromJson(x)));

String modelGovernsToJson(List<ModelGoverns> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelGoverns {
  ModelGoverns({
    this.id,
    this.name,
    this.code,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.govs,
    this.resourceUrl,
  });

  int? id;
  String? name;
  String? code;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Gov>? govs;
  String? resourceUrl;

  factory ModelGoverns.fromJson(Map<String, dynamic> json) => ModelGoverns(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    govs: List<Gov>.from(json["govs"].map((x) => Gov.fromJson(x))),
    resourceUrl: json["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "phone": phone,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "govs": List<dynamic>.from(govs!.map((x) => x.toJson())),
    "resource_url": resourceUrl,
  };
}

class Gov {
  Gov({
    this.id,
    this.name,
    this.price,
    this.shipping,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.cities,
    this.resourceUrl,
  });

  int? id;
  String? name;
  int? price;
  Shipping? shipping;
  int? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<City>? cities;
  String? resourceUrl;

  factory Gov.fromJson(Map<String, dynamic> json) => Gov(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    shipping: Shipping.fromJson(json["shipping"]),
    countryId: json["country_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
    resourceUrl: json["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "shipping": shipping!.toJson(),
    "country_id": countryId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "cities": List<dynamic>.from(cities!.map((x) => x.toJson())),
    "resource_url": resourceUrl,
  };
}

class City {
  City({
    this.id,
    this.name,
    this.govId,
    this.createdAt,
    this.updatedAt,
    this.resourceUrl,
  });

  int? id;
  String? name;
  int? govId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? resourceUrl;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    govId: json["gov_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    resourceUrl: json["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gov_id": govId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "resource_url": resourceUrl,
  };
}

class Shipping {
  Shipping({
    this.barq,
    this.green,
    this.quick,
  });

  dynamic barq;
  int? green;
  dynamic quick;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    barq: json["BARQ"],
    green: json["GREEN"],
    quick: json["QUICK"],
  );

  Map<String, dynamic> toJson() => {
    "BARQ": barq,
    "GREEN": green,
    "QUICK": quick,
  };
}
