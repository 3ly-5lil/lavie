class Tool {
  Tool({
    this.toolId,
    this.name,
    this.description,
    this.imageUrl,
  });

  Tool.fromJson(dynamic json) {
    toolId = json['toolId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  String? toolId;
  String? name;
  String? description;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['toolId'] = toolId;
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    return map;
  }
}
