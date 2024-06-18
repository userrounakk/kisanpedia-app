import 'dart:convert';

StoreResponse storeResponseFromJson(String str) =>
    StoreResponse.fromJson(json.decode(str));

String storeResponseToJson(StoreResponse data) => json.encode(data.toJson());

class StoreResponse {
  bool success;
  List<Store> stores;

  StoreResponse({
    required this.success,
    required this.stores,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
        success: json["success"],
        stores: List<Store>.from(json["data"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class Store {
  String id;
  String name;
  String city;
  String street;
  String address;
  String mapInfo;
  int v;

  Store({
    required this.id,
    required this.name,
    required this.city,
    required this.street,
    required this.address,
    required this.mapInfo,
    required this.v,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        name: json["name"],
        city: json["city"],
        street: json["street"],
        address: json["address"],
        mapInfo: json["mapInfo"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "city": city,
        "street": street,
        "address": address,
        "mapInfo": mapInfo,
        "__v": v,
      };
}
