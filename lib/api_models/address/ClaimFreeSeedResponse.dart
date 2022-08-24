class ClaimFreeSeedResponse {
  ClaimFreeSeedResponse({
    this.type,
    this.message,
    this.data,
  });

  ClaimFreeSeedResponse.fromJson(dynamic json) {
    type = json['type'];
    message = json['message'];
    data = json['data'];
  }

  String? type;
  String? message;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}
