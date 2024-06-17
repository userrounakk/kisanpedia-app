import 'dart:convert';

SellerResponse sellerResponseFromJson(String str) =>
    SellerResponse.fromJson(json.decode(str));

String sellerResponseToJson(SellerResponse data) => json.encode(data.toJson());

class SellerResponse {
  bool success;
  List<Seller> seller;

  SellerResponse({
    required this.success,
    required this.seller,
  });

  factory SellerResponse.fromJson(Map<String, dynamic> json) => SellerResponse(
        success: json["success"],
        seller: List<Seller>.from(json["data"].map((x) => Seller.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(seller.map((x) => x.toJson())),
      };
}

class Seller {
  String id;
  String name;
  String image;
  List<String> location;
  List<String> products;
  String description;
  String phoneNumber;

  Seller({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.products,
    required this.description,
    required this.phoneNumber,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        location: List<String>.from(json["location"].map((x) => x)),
        products: List<String>.from(json["products"].map((x) => x)),
        description: json["description"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "location": List<dynamic>.from(location.map((x) => x)),
        "products": List<dynamic>.from(products.map((x) => x)),
        "description": description,
        "phoneNumber": phoneNumber,
      };
}
