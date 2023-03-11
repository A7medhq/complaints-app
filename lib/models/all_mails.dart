// To parse this JSON data, do
//
//     final allMails = allMailsFromJson(jsonString);

import 'dart:convert';

AllMails allMailsFromJson(String str) => AllMails.fromJson(json.decode(str));

String allMailsToJson(AllMails data) => json.encode(data.toJson());

class AllMails {
  AllMails({
    required this.mails,
  });

  List<Mail> mails;

  factory AllMails.fromJson(Map<String, dynamic> json) => AllMails(
        mails: List<Mail>.from(json["mails"].map((x) => Mail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mails": List<dynamic>.from(mails.map((x) => x.toJson())),
      };
}

class Mail {
  Mail({
    required this.id,
    required this.subject,
    this.description,
    required this.senderId,
    required this.archiveNumber,
    required this.archiveDate,
    this.decision,
    required this.statusId,
    this.finalDecision,
    required this.createdAt,
    required this.updatedAt,
    required this.sender,
    required this.status,
    required this.tags,
    required this.attachments,
    required this.activities,
  });

  int id;
  String subject;
  String? description;
  String senderId;
  String archiveNumber;
  DateTime archiveDate;
  String? decision;
  String statusId;
  String? finalDecision;
  DateTime createdAt;
  DateTime updatedAt;
  Sender sender;
  Status status;
  List<Category> tags;
  List<Attachment> attachments;
  List<dynamic> activities;

  factory Mail.fromJson(Map<String, dynamic> json) => Mail(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        senderId: json["sender_id"],
        archiveNumber: json["archive_number"],
        archiveDate: DateTime.parse(json["archive_date"]),
        decision: json["decision"],
        statusId: json["status_id"],
        finalDecision: json["final_decision"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sender: Sender.fromJson(json["sender"]),
        status: Status.fromJson(json["status"]),
        tags:
            List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        activities: List<dynamic>.from(json["activities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "sender_id": senderId,
        "archive_number": archiveNumber,
        "archive_date": archiveDate.toIso8601String(),
        "decision": decision,
        "status_id": statusId,
        "final_decision": finalDecision,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sender": sender.toJson(),
        "status": status.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "activities": List<dynamic>.from(activities.map((x) => x)),
      };
}

class Attachment {
  Attachment({
    required this.id,
    required this.title,
    required this.image,
    required this.mailId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String image;
  String mailId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        mailId: json["mail_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "mail_id": mailId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Sender {
  Sender({
    required this.id,
    required this.name,
    required this.mobile,
    this.address,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  int id;
  String name;
  String mobile;
  String? address;
  String categoryId;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.pivot,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot? pivot;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.mailId,
    required this.tagId,
  });

  String mailId;
  String tagId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        mailId: json["mail_id"],
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toJson() => {
        "mail_id": mailId,
        "tag_id": tagId,
      };
}

class Status {
  Status({
    required this.id,
    required this.name,
    required this.color,
  });

  int id;
  String name;
  String color;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
      };
}
