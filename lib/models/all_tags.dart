// To parse this JSON data, do
//
//     final tagModel = tagModelFromJson(jsonString);

import 'dart:convert';

TagsModel tagModelFromJson(String str) => TagsModel.fromJson(json.decode(str));

String tagModelToJson(TagsModel data) => json.encode(data.toJson());

class TagsModel {
  TagsModel({
    required this.tags,
  });

  List<Tag> tags;

  factory TagsModel.fromJson(Map<String, dynamic> json) => TagsModel(
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}

class Tag {
  Tag({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
