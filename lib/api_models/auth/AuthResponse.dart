import 'AuthData.dart';

class AuthResponse {
  AuthResponse({
    this.type,
    this.message,
    this.data,
  });

  AuthResponse.fromJson(dynamic json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? AuthData.fromJson(json['data']) : null;
  }

  String? type;
  String? message;
  AuthData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}
