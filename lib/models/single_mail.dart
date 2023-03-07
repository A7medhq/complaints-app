// To parse this JSON data, do
//
//     final mail = mailFromJson(jsonString);

import 'dart:convert';

Mail mailFromJson(String str) => Mail.fromJson(json.decode(str));

String mailToJson(Mail data) => json.encode(data.toJson());

class Mail {
  Mail({
    required this.message,
    required this.mail,
  });

  String message;
  MailClass mail;

  factory Mail.fromJson(Map<String, dynamic> json) => Mail(
        message: json["message"],
        mail: MailClass.fromJson(json["mail"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "mail": mail.toJson(),
      };
}

class MailClass {
  MailClass({
    required this.id,
    required this.subject,
    required this.description,
    required this.senderId,
    required this.archiveNumber,
    required this.archiveDate,
    this.decision,
    required this.statusId,
    this.finalDecision,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String subject;
  String description;
  String senderId;
  String archiveNumber;
  DateTime archiveDate;
  dynamic decision;
  String statusId;
  dynamic finalDecision;
  DateTime createdAt;
  DateTime updatedAt;

  factory MailClass.fromJson(Map<String, dynamic> json) => MailClass(
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
      };
}
