// To parse this JSON data, do
//
//     final allMailsOfTags = allMailsOfTagsFromJson(jsonString);

import 'dart:convert';

AllMailsOfTags allMailsOfTagsFromJson(String str) =>
    AllMailsOfTags.fromJson(json.decode(str));

String allMailsOfTagsToJson(AllMailsOfTags data) => json.encode(data.toJson());

class AllMailsOfTags {
  AllMailsOfTags({
    required this.tags,
  });

  List<Tag> tags;

  factory AllMailsOfTags.fromJson(Map<String, dynamic> json) => AllMailsOfTags(
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
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
  Tag category;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Tag.fromJson(json["category"]),
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
    required this.pivot,
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
  Pivot pivot;
  Sender sender;
  Status status;
  List<Tag> tags;
  List<Attachment> attachments;
  List<Activity> activities;

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
        pivot: Pivot.fromJson(json["pivot"]),
        sender: Sender.fromJson(json["sender"]),
        status: Status.fromJson(json["status"]),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        activities: List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
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
        "pivot": pivot.toJson(),
        "sender": sender.toJson(),
        "status": status.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.mails,
    this.pivot,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  List<Mail>? mails;
  Pivot? pivot;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
        "pivot": pivot?.toJson(),
      };
}

class Activity {
  Activity({
    required this.id,
    required this.body,
    required this.userId,
    required this.mailId,
    this.sendNumber,
    this.sendDate,
    this.sendDestination,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  String body;
  String userId;
  String mailId;
  dynamic sendNumber;
  dynamic sendDate;
  dynamic sendDestination;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        body: json["body"],
        userId: json["user_id"],
        mailId: json["mail_id"],
        sendNumber: json["send_number"],
        sendDate: json["send_date"],
        sendDestination: json["send_destination"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "user_id": userId,
        "mail_id": mailId,
        "send_number": sendNumber,
        "send_date": sendDate,
        "send_destination": sendDestination,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.emailVerifiedAt,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic image;
  dynamic emailVerifiedAt;
  String roleId;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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

class Pivot {
  Pivot({
    required this.tagId,
    required this.mailId,
  });

  String tagId;
  String mailId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        tagId: json["tag_id"],
        mailId: json["mail_id"],
      );

  Map<String, dynamic> toJson() => {
        "tag_id": tagId,
        "mail_id": mailId,
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
