import 'Product.dart';

class FetchProductsResponse {
  FetchProductsResponse({
    this.type,
    this.message,
    this.data,
  });

  FetchProductsResponse.fromJson(dynamic json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
  }

  String? type;
  String? message;
  List<Product>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
