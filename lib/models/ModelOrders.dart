// To parse this JSON data, do
//
//     final modelOrders = modelOrdersFromJson(jsonString);

import 'dart:convert';

ModelOrders modelOrdersFromJson(String str) => ModelOrders.fromJson(json.decode(str));

String modelOrdersToJson(ModelOrders data) => json.encode(data.toJson());

class ModelOrders {
  ModelOrders({
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

  factory ModelOrders.fromJson(Map<String, dynamic> json) => ModelOrders(
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

class Datum {
  Datum({
    this.id,
    this.userId,
    this.customerId,
    this.name,
    this.phone,
    this.flat,
    this.address,
    this.govId,
    this.cityId,
    this.source,
    this.branch,
    this.username,
    this.delivery,
    this.status,
    this.total,
    this.discount,
    this.fee,
    this.shipped,
    this.notes,
    this.notesAfter,
    this.done,
    this.datumReturn,
    this.returnTotal,
    this.reason,
    this.activated,
    this.support,
    this.payment,
    this.paymentMethod,
    this.info,
    this.shipperVendor,
    this.shipperVendorId,
    this.paymentVendor,
    this.paymentVendorId,
    this.promoId,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.resourceUrl,
  });

  int? id;
  UserId? userId;
  CustomerId? customerId;
  String? name;
  String? phone;
  dynamic flat;
  String? address;
  GovId? govId;
  CityId? cityId;
  String? source;
  Branch? branch;
  dynamic username;
  Branch? delivery;
  String? status;
  int? total;
  int? discount;
  int? fee;
  int? shipped;
  dynamic notes;
  dynamic notesAfter;
  int? done;
  int? datumReturn;
  int? returnTotal;
  String? reason;
  int? activated;
  int? support;
  int? payment;
  String? paymentMethod;
  dynamic info;
  dynamic shipperVendor;
  dynamic shipperVendorId;
  dynamic paymentVendor;
  dynamic paymentVendorId;
  dynamic promoId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Item>? items;
  String? resourceUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: UserId.fromJson(json["user_id"]),
    customerId: CustomerId.fromJson(json["customer_id"]),
    name: json["name"],
    phone: json["phone"],
    flat: json["flat"],
    address: json["address"],
    govId: GovId.fromJson(json["gov_id"]),
    cityId: CityId.fromJson(json["city_id"]),
    source: json["source"],
    branch: Branch.fromJson(json["branch"]),
    username: json["username"],
    delivery: Branch.fromJson(json["delivery"]),
    status: json["status"],
    total: json["total"],
    discount: json["discount"],
    fee: json["fee"],
    shipped: json["shipped"],
    notes: json["notes"],
    notesAfter: json["notes_after"],
    done: json["done"],
    datumReturn: json["return"],
    returnTotal: json["return_total"],
    reason: json["reason"],
    activated: json["activated"],
    support: json["support"],
    payment: json["payment"],
    paymentMethod: json["payment_method"],
    info: json["info"],
    shipperVendor: json["shipper_vendor"],
    shipperVendorId: json["shipper_vendor_id"],
    paymentVendor: json["payment_vendor"],
    paymentVendorId: json["payment_vendor_id"],
    promoId: json["promo_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    resourceUrl: json["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId!.toJson(),
    "customer_id": customerId!.toJson(),
    "name": name,
    "phone": phone,
    "flat": flat,
    "address": address,
    "gov_id": govId!.toJson(),
    "city_id": cityId!.toJson(),
    "source": source,
    "branch": branch!.toJson(),
    "username": username,
    "delivery": delivery!.toJson(),
    "status": status,
    "total": total,
    "discount": discount,
    "fee": fee,
    "shipped": shipped,
    "notes": notes,
    "notes_after": notesAfter,
    "done": done,
    "return": datumReturn,
    "return_total": returnTotal,
    "reason": reason,
    "activated": activated,
    "support": support,
    "payment": payment,
    "payment_method": paymentMethod,
    "info": info,
    "shipper_vendor": shipperVendor,
    "shipper_vendor_id": shipperVendorId,
    "payment_vendor": paymentVendor,
    "payment_vendor_id": paymentVendorId,
    "promo_id": promoId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "resource_url": resourceUrl,
  };
}

class Branch {
  Branch({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.resourceUrl,
  });

  int? id;
  String? name;
  String? phone;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? resourceUrl;

  factory Branch.fromJson(Map<String, dynamic>? json) => Branch(
    id: json?["id"],
    name: json?["name"],
    phone: json?["phone"],
    address: json?["address"] == null ? null : json?["address"],
    createdAt: json?["created_at"],
    updatedAt: json?["updated_at"],
    resourceUrl: json?["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "address": address == null ? null : address,
    "created_at": createdAt!,
    "updated_at": updatedAt!,
    "resource_url": resourceUrl,
  };
}

class CityId {
  CityId({
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

  factory CityId.fromJson(Map<String, dynamic> json) => CityId(
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

class CustomerId {
  CustomerId({
    this.id,
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
    this.resourceUrl,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? address;
  int? countyId;
  int? govId;
  int? cityId;
  dynamic info;
  int? login;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullName;
  String? resourceUrl;

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    countyId: json["county_id"],
    govId: json["gov_id"],
    cityId: json["city_id"],
    info: json["info"],
    login: json["login"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    fullName: json["full_name"],
    resourceUrl: json["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "address": address,
    "county_id": countyId,
    "gov_id": govId,
    "city_id": cityId,
    "info": info,
    "login": login,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "full_name": fullName,
    "resource_url": resourceUrl,
  };
}

class GovId {
  GovId({
    this.id,
    this.name,
    this.price,
    this.shipping,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.resourceUrl,
  });

  int? id;
  String? name;
  int? price;
  Shipping? shipping;
  int? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? resourceUrl;

  factory GovId.fromJson(Map<String, dynamic> json) => GovId(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    shipping: Shipping.fromJson(json["shipping"]),
    countryId: json["country_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "resource_url": resourceUrl,
  };
}

class Shipping {
  Shipping({
    this.barq,
    this.green,
    this.quick,
  });

  int? barq;
  int? green;
  int? quick;

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

class Item {
  Item({
    this.id,
    this.orderId,
    this.customerId,
    this.productId,
    this.vars,
    this.item,
    this.qnt,
    this.returnQnt,
    this.price,
    this.discount,
    this.fee,
    this.total,
    this.itemReturn,
    this.createdAt,
    this.updatedAt,
    this.refundId,
    this.options,
  });

  int? id;
  int? orderId;
  int? customerId;
  ProductId? productId;
  List<String>? vars;
  dynamic item;
  int? qnt;
  int? returnQnt;
  int? price;
  dynamic discount;
  int? fee;
  int? total;
  int? itemReturn;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic refundId;
  List<String>? options;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    customerId: json["customer_id"],
    productId: ProductId.fromJson(json["product_id"]),
    vars: List<String>.from(json["vars"].map((x) => x)),
    item: json["item"],
    qnt: json["qnt"],
    returnQnt: json["return_qnt"],
    price: json["price"],
    discount: json["discount"],
    fee: json["fee"],
    total: json["total"],
    itemReturn: json["return"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    refundId: json["refund_id"],
    options: List<String>.from(json["options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "customer_id": customerId,
    "product_id": productId!.toJson(),
    "vars": List<dynamic>.from(vars!.map((x) => x)),
    "item": item,
    "qnt": qnt,
    "return_qnt": returnQnt,
    "price": price,
    "discount": discount,
    "fee": fee,
    "total": total,
    "return": itemReturn,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "refund_id": refundId,
    "options": List<dynamic>.from(options!.map((x) => x)),
  };
}

class ProductId {
  ProductId({
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
    this.cost,
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
  });

  int? id;
  String? type;
  int? rate;
  String? name;
  String? images;
  List<Var>? vars;
  dynamic brand;
  String? description;
  String? slug;
  int? requireShipping;
  dynamic weight;
  String? sku;
  dynamic cost;
  int? price;
  dynamic stock;
  dynamic posPrice;
  dynamic websitePrice;
  dynamic discount;
  dynamic posDiscount;
  dynamic websiteDiscount;
  dynamic discountTo;
  dynamic qnt;
  dynamic subtitle;
  dynamic seoTitle;
  dynamic seoDescription;
  dynamic seoKeywords;
  dynamic fee;
  int? trend;
  int? enabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? resourceUrl;

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["id"],
    type: json["type"],
    rate: json["rate"],
    name: json["name"],
    images: json["images"],
    vars: List<Var>.from(json["vars"].map((x) => Var.fromJson(x))),
    brand: json["brand"],
    description: json["description"],
    slug: json["slug"],
    requireShipping: json["require_shipping"],
    weight: json["weight"],
    sku: json["sku"],
    cost: json["cost"],
    price: json["price"],
    stock: json["stock"],
    posPrice: json["pos_price"],
    websitePrice: json["website_price"],
    discount: json["discount"],
    posDiscount: json["pos_discount"],
    websiteDiscount: json["website_discount"],
    discountTo: json["discount_to"],
    qnt: json["qnt"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "rate": rate,
    "name": name,
    "images": images,
    "vars": List<dynamic>.from(vars!.map((x) => x.toJson())),
    "brand": brand,
    "description": description,
    "slug": slug,
    "require_shipping": requireShipping,
    "weight": weight,
    "sku": sku,
    "cost": cost,
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
  };
}

class Var {
  Var({
    this.name,
    this.type,
    this.rel,
    this.value,
  });

  String? name;
  String? type;
  dynamic rel;
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

class Value {
  Value({
    this.label,
    this.color,
    this.price,
    this.cost,
  });

  String? label;
  dynamic color;
  dynamic price;
  dynamic cost;

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

class UserId {
  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.activated,
    this.forbidden,
    this.language,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
    this.apiToken,
    this.apps,
    this.fullName,
    this.resourceUrl,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? activated;
  int? forbidden;
  String? language;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastLoginAt;
  dynamic apiToken;
  List<App>? apps;
  String? fullName;
  String? resourceUrl;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    activated: json["activated"],
    forbidden: json["forbidden"],
    language: json["language"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    lastLoginAt: DateTime.parse(json["last_login_at"]),
    apiToken: json["api_token"],
    apps: List<App>.from(json["apps"].map((x) => App.fromJson(x))),
    fullName: json["full_name"],
    resourceUrl: json["resource_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "activated": activated,
    "forbidden": forbidden,
    "language": language,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "last_login_at": lastLoginAt!.toIso8601String(),
    "api_token": apiToken,
    "apps": List<dynamic>.from(apps!.map((x) => x.toJson())),
    "full_name": fullName,
    "resource_url": resourceUrl,
  };
}

class App {
  App({
    this.id,
    this.path,
    this.name,
    this.type,
    this.slug,
    this.key,
    this.by,
    this.description,
    this.installation,
    this.rate,
    this.version,
    this.required,
    this.module,
    this.clone,
    this.lastUpdate,
    this.active,
    this.installed,
    this.views,
    this.price,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.resourceUrl,
    this.pivot,
  });

  int? id;
  String? path;
  String? name;
  Type? type;
  String? slug;
  String? key;
  By? by;
  String? description;
  String? installation;
  int? rate;
  String? version;
  dynamic required;
  String? module;
  Clone? clone;
  DateTime? lastUpdate;
  int? active;
  int? installed;
  int? views;
  dynamic price;
  dynamic discount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? resourceUrl;
  Pivot? pivot;

  factory App.fromJson(Map<String, dynamic> json) => App(
    id: json["id"],
    path: json["path"],
    name: json["name"],
    type: typeValues.map[json["type"]],
    slug: json["slug"],
    key: json["key"],
    by: byValues.map[json["by"]],
    description: json["description"],
    installation: json["installation"],
    rate: json["rate"],
    version: json["version"],
    required: json["required"],
    module: json["module"],
    clone: cloneValues.map[json["clone"]],
    lastUpdate: DateTime.parse(json["last_update"]),
    active: json["active"],
    installed: json["installed"],
    views: json["views"],
    price: json["price"],
    discount: json["discount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    resourceUrl: json["resource_url"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
    "name": name,
    "type": typeValues.reverse![type!],
    "slug": slug,
    "key": key,
    "by": byValues.reverse![by!],
    "description": description,
    "installation": installation,
    "rate": rate,
    "version": version,
    "required": required,
    "module": module,
    "clone": cloneValues.reverse![clone!],
    "last_update": lastUpdate!.toIso8601String(),
    "active": active,
    "installed": installed,
    "views": views,
    "price": price,
    "discount": discount,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "resource_url": resourceUrl,
    "pivot": pivot!.toJson(),
  };
}

enum By { O2_MICRO }

final byValues = EnumValues({
  "O2 Micro": By.O2_MICRO
});

enum Clone { GITHUB_COM }

final cloneValues = EnumValues({
  "github.com": Clone.GITHUB_COM
});

class Pivot {
  Pivot({
    this.appId,
    this.userId,
  });

  int? appId;
  int? userId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    appId: json["app_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "app_id": appId,
    "user_id": userId,
  };
}

enum Type { MODULE }

final typeValues = EnumValues({
  "module": Type.MODULE
});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
