import 'dart:convert';

PlantResponse plantResponseFromJson(String str) =>
    PlantResponse.fromJson(json.decode(str));

String plantResponseToJson(PlantResponse data) => json.encode(data.toJson());

class PlantResponse {
  bool success;
  List<Plant> plant;

  PlantResponse({
    required this.success,
    required this.plant,
  });

  factory PlantResponse.fromJson(Map<String, dynamic> json) => PlantResponse(
        success: json["success"],
        plant: List<Plant>.from(json["data"].map((x) => Plant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(plant.map((x) => x.toJson())),
      };
}

class Plant {
  String id;
  String name;
  String image;
  int price;
  List<String> location;
  String description;

  Plant({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.location,
    required this.description,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        location: List<String>.from(json["location"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "price": price,
        "location": List<dynamic>.from(location.map((x) => x)),
        "description": description,
      };
}
