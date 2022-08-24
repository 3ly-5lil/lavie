import 'Seed.dart';
import 'Tool.dart';

class Product {
  Product({
    this.productId,
    this.name,
    this.description,
    this.imageUrl,
    this.type,
    this.price,
    this.available,
    this.seed,
    this.plant,
    this.tool,
  });

  Product.fromJson(dynamic json) {
    productId = json['productId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    price = json['price'];
    available = json['available'];
    seed = json['seed'] != null ? Seed.fromJson(json['seed']) : null;
    plant = json['plant'] != null ? Product.fromJson(json['plant']) : null;
    tool = json['tool'] != null ? Tool.fromJson(json['tool']) : null;
  }

  String? productId;
  String? name;
  String? description;
  String? imageUrl;
  String? type;
  int? price;
  bool? available;
  Seed? seed;
  Product? plant;
  Tool? tool;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['type'] = type;
    map['price'] = price;
    map['available'] = available;
    if (seed != null) {
      map['seed'] = seed!.toJson();
    }
    if (plant != null) {
      map['plant'] = plant!.toJson();
    }
    if (tool != null) {
      map['tool'] = tool!.toJson();
    }
    return map;
  }
}
