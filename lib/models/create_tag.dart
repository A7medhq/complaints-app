// To parse this JSON data, do
//
//     final createTag = createTagFromJson(jsonString);

import 'dart:convert';

CreateTag createTagFromJson(String str) => CreateTag.fromJson(json.decode(str));

String createTagToJson(CreateTag data) => json.encode(data.toJson());

class CreateTag {
  CreateTag({
    required this.message,
    required this.tag,
  });

  String message;
  Tag tag;

  factory CreateTag.fromJson(Map<String, dynamic> json) => CreateTag(
        message: json["message"],
        tag: Tag.fromJson(json["tag"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "tag": tag.toJson(),
      };
}

class Tag {
  Tag({
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String name;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
