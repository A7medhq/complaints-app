// To parse this JSON data, do
//
//     final StatusModal = StatusModalFromJson(jsonString);

import 'dart:convert';

StatusModal statusModelFromJson(String str) => StatusModal.fromJson(json.decode(str));

String statusModeltoJson(StatusModal data) => json.encode(data.toJson());

class StatusModal {
  StatusModal({
    required this.statuses,
  });

  List<Status> statuses;

  factory StatusModal.fromJson(Map<String, dynamic> json) => StatusModal(
    statuses: List<Status>.from(json["statuses"].map((x) => Status.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statuses": List<dynamic>.from(statuses.map((x) => x.toJson())),
  };
}

class Status {
  Status({
    required this.id,
    required this.name,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.mailsCount,
  });

  int id;
  String name;
  String color;
  DateTime createdAt;
  DateTime updatedAt;
  String mailsCount;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    mailsCount: json["mails_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "mails_count": mailsCount,
  };
}
