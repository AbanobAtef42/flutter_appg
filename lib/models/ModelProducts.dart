import 'dart:convert';

import 'package:hive/hive.dart';

part 'ModelProducts.g.dart';

List<ModelProducts> modelProductsFromJson(String str) => List<ModelProducts>.from(json.decode(str).map((x) => ModelProducts.fromJson(x)));
List<ModelProducts> modelProductsFromJson2(String str) => List<ModelProducts>.from(json.decode(str).map((x) => ModelProducts.fromJson2(x)));

String modelProductsToJson(List<ModelProducts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProducts {
  ModelProducts({
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
  
  List<Datum>? data;
  
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

  factory ModelProducts.fromJson(Map<String, dynamic> json) => ModelProducts(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
  factory ModelProducts.fromJson2(Map<String, dynamic> json) => ModelProducts(
    //currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    /*firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],*/
  );

  Map<String, dynamic> toJson() => {
    //"current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    /*"first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,*/
  };
}
@HiveType(typeId: 1)
class Datum {
  Datum({
    this.id,
    this.type,
    this.rate,
    this.name,
    this.images,
    this.vars,
    this.brand,
    this.description,
    this.slug,
    this.requireShipping,
    this.weight,
    this.sku,
    this.price,
    this.stock,
    this.posPrice,
    this.websitePrice,
    this.discount,
    this.posDiscount,
    this.websiteDiscount,
    this.discountTo,
    this.qnt,
    this.subtitle,
    this.seoTitle,
    this.seoDescription,
    this.seoKeywords,
    this.fee,
    this.trend,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.resourceUrl,
    this.category,
    this.tag,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? type;
  @HiveField(2)
  String? rate;
  @HiveField(3)
  String? name;
  @HiveField(4)
  List<String>? images;
  @HiveField(5)
  List<Var>? vars;
  @HiveField(6)
  String? brand;
  @HiveField(7)
  String? description;
  @HiveField(8)
  String? slug;
  @HiveField(9)
  String? requireShipping;
  @HiveField(10)
  String? weight;
  @HiveField(11)
  String? sku;
  @HiveField(12)
  String? price;
  @HiveField(13)
  String? stock;
  @HiveField(14)
  String? posPrice;
  @HiveField(15)
  String? websitePrice;
  @HiveField(16)
  String? discount;
  @HiveField(17)
  String? posDiscount;
  @HiveField(18)
  String? websiteDiscount;
  @HiveField(19)
  String? discountTo;
  @HiveField(20)
  String? qnt;
  @HiveField(21)
  String? subtitle;
  @HiveField(22)
  String? seoTitle;
  @HiveField(23)
  String? seoDescription;
  @HiveField(24)
  String? seoKeywords;
  @HiveField(25)
  String? fee;
  @HiveField(26)
  int? trend;
  @HiveField(27)
  int? enabled;
  @HiveField(28)
  DateTime? createdAt;
  @HiveField(29)
  DateTime? updatedAt;
  @HiveField(30)
  String? resourceUrl;
  //@HiveField(31)
  List<Category>? category;
  @HiveField(31)
  List<String>? tag;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    rate: json["rate"].toString(),
    name: json["name"],
    images: List<String>.from(json["images"].map((x) => x)),
    vars: List<Var>.from(json["vars"].map((x) => Var.fromJson(x))),
    brand: json["brand"],
    description: json["description"],
    slug: json["slug"],
    requireShipping: json["require_shipping"].toString(),
    weight: json["weight"],
    sku: json["sku"],
    price: json["price"].toString(),
    stock: json["stock"].toString(),
    posPrice: json["pos_price"],
    websitePrice: json["website_price"],
    discount: json["discount"].toString(),
    posDiscount: json["pos_discount"].toString(),
    websiteDiscount: json["website_discount"].toString(),
    discountTo: json["discount_to"].toString(),
    qnt: json["qnt"].toString(),
    subtitle: json["subtitle"],
    seoTitle: json["seo_title"],
    seoDescription: json["seo_description"],
    seoKeywords: json["seo_keywords"],
    fee: json["fee"],
    trend: json["trend"],
    enabled: json["enabled"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    resourceUrl: json["resource_url"],
 //   category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  //  tag: List<String>.from(json["tag"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "rate": rate,
    "name": name,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "vars": List<dynamic>.from(vars!.map((x) => x.toJson())),
    "brand": brand,
    "description": description,
    "slug": slug,
    "require_shipping": requireShipping,
    "weight": weight,
    "sku": sku,
    "price": price,
    "stock": stock,
    "pos_price": posPrice,
    "website_price": websitePrice,
    "discount": discount,
    "pos_discount": posDiscount,
    "website_discount": websiteDiscount,
    "discount_to": discountTo,
    "qnt": qnt,
    "subtitle": subtitle,
    "seo_title": seoTitle,
    "seo_description": seoDescription,
    "seo_keywords": seoKeywords,
    "fee": fee,
    "trend": trend,
    "enabled": enabled,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "resource_url": resourceUrl,
   // "category": List<dynamic>.from(category.map((x) => x.toJson())),
   // "tag": List<dynamic>.from(tag.map((x) => x)),
  };
}

class Category extends HiveObject {
  Category({
    this.id,
    this.name,
    this.image,
    this.slug,
    this.seoDescription,
    this.seoKeywords,
    this.sub,
    this.active,
    this.menu,
    this.createdAt,
    this.updatedAt,
    this.resourceUrl,
    this.pivot,
  });

  int? id;
  String? name;
  String? image;
  String? slug;
  String? seoDescription;
  String? seoKeywords;
  String? sub;
  int? active;
  int? menu;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? resourceUrl;
  Pivot? pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
    seoDescription: json["seo_description"],
    seoKeywords: json["seo_keywords"],
    sub: json["sub"],
    active: json["active"],
    menu: json["menu"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    resourceUrl: json["resource_url"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
    "seo_description": seoDescription,
    "seo_keywords": seoKeywords,
    "sub": sub,
    "active": active,
    "menu": menu,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "resource_url": resourceUrl,
    "pivot": pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.productId,
    this.categoryId,
  });

  int? productId;
  int? categoryId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "category_id": categoryId,
  };
}
@HiveType(typeId: 2)
class Var extends HiveObject {
  Var({

    this.name,
    this.type,
    this.rel,
    this.value,
  });
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? type;
  @HiveField(2)
  String? rel;
  @HiveField(3)
  List<Value>? value;

  factory Var.fromJson(Map<String, dynamic> json) => Var(
    name: json["name"],
    type: json["type"],
    rel: json["rel"],
    value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "rel": rel,
    "value": List<dynamic>.from(value!.map((x) => x.toJson())),
  };
}
@HiveType(typeId: 3)
class Value extends HiveObject{
  Value({
    this.label,
    this.color,
    this.price,
    this.cost,
  });
  @HiveField(0)
  String? label;
  @HiveField(1)
  String? color;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? cost;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    label: json["label"],
    color: json["color"],
    price: json["price"],
    cost: json["cost"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "color": color,
    "price": price,
    "cost": cost,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  dynamic label;
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