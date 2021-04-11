// To parse this JSON data, do
//
//     final modelSetting = modelSettingFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';



List<ModelSetting> modelSettingFromJson(String str) => List<ModelSetting>.from(json.decode(str).map((x) => ModelSetting.fromJson(x)));

String modelSettingToJson(List<ModelSetting> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSetting {
  ModelSetting({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Datum2>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory ModelSetting.fromJson(Map<String, dynamic> json) => ModelSetting(
    currentPage: json["current_page"],
    data: List<Datum2>.from(json["data"].map((x) => Datum2.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum2 {
  Datum2({
    this.id,
    this.key,
    this.group,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.resourceUrl,
  });

  int? id;
  String? key;
  String? group;
  String? value;
  String? createdAt;
  String? updatedAt;
  String? resourceUrl;

  factory Datum2.fromJson(Map<String, dynamic> json) => Datum2(
    id: json["id"],
    key: json["key"],
    group: json["group"],
    value: json["value"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    resourceUrl: json["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "group": group,
    "value": value,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "resource_url": resourceUrl,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
