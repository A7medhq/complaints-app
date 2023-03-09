// // To parse this JSON data, do
// //
// //     final mails = mailsFromJson(jsonString);
//
// import 'dart:convert';
//
// AllMails mailsFromJson(String str) => AllMails.fromJson(json.decode(str));
//
// String mailsToJson(AllMails data) => json.encode(data.toJson());
//
// class AllMails {
//   AllMails({
//     required this.mails,
//   });
//
//   MailsClass mails;
//
//   factory AllMails.fromJson(Map<String, dynamic> json) => AllMails(
//         mails: MailsClass.fromJson(json["mails"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "mails": mails.toJson(),
//       };
// }
//
// class MailsClass {
//   MailsClass({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.links,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//
//   int currentPage;
//   List<Datum> data;
//   String firstPageUrl;
//   int from;
//   int lastPage;
//   String lastPageUrl;
//   List<Link> links;
//   String nextPageUrl;
//   String path;
//   int perPage;
//   dynamic prevPageUrl;
//   int to;
//   int total;
//
//   factory MailsClass.fromJson(Map<String, dynamic> json) => MailsClass(
//         currentPage: json["current_page"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": List<dynamic>.from(links.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.subject,
//     this.description,
//     required this.senderId,
//     required this.archiveNumber,
//     required this.archiveDate,
//     this.decision,
//     required this.statusId,
//     this.finalDecision,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.sender,
//     required this.status,
//     required this.tags,
//     required this.attachments,
//     required this.activities,
//   });
//
//   int id;
//   String subject;
//   Description? description;
//   String senderId;
//   String archiveNumber;
//   DateTime archiveDate;
//   String? decision;
//   String statusId;
//   String? finalDecision;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Sender sender;
//   Status status;
//   List<Category> tags;
//   List<dynamic> attachments;
//   List<Activity> activities;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         subject: json["subject"],
//         description: descriptionValues.map[json["description"]]!,
//         senderId: json["sender_id"],
//         archiveNumber: json["archive_number"],
//         archiveDate: DateTime.parse(json["archive_date"]),
//         decision: json["decision"],
//         statusId: json["status_id"],
//         finalDecision: json["final_decision"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         sender: Sender.fromJson(json["sender"]),
//         status: Status.fromJson(json["status"]),
//         tags:
//             List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
//         attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
//         activities: List<Activity>.from(
//             json["activities"].map((x) => Activity.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "subject": subject,
//         "description": descriptionValues.reverse[description],
//         "sender_id": senderId,
//         "archive_number": archiveNumber,
//         "archive_date": archiveDate.toIso8601String(),
//         "decision": decision,
//         "status_id": statusId,
//         "final_decision": finalDecision,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "sender": sender.toJson(),
//         "status": status.toJson(),
//         "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
//         "attachments": List<dynamic>.from(attachments.map((x) => x)),
//         "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
//       };
// }
//
// class Activity {
//   Activity({
//     required this.id,
//     required this.body,
//     required this.userId,
//     required this.mailId,
//     this.sendNumber,
//     this.sendDate,
//     this.sendDestination,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.user,
//   });
//
//   int id;
//   Body body;
//   String userId;
//   String mailId;
//   dynamic sendNumber;
//   dynamic sendDate;
//   dynamic sendDestination;
//   DateTime createdAt;
//   DateTime updatedAt;
//   User user;
//
//   factory Activity.fromJson(Map<String, dynamic> json) => Activity(
//         id: json["id"],
//         body: bodyValues.map[json["body"]]!,
//         userId: json["user_id"],
//         mailId: json["mail_id"],
//         sendNumber: json["send_number"],
//         sendDate: json["send_date"],
//         sendDestination: json["send_destination"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         user: User.fromJson(json["user"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "body": bodyValues.reverse[body],
//         "user_id": userId,
//         "mail_id": mailId,
//         "send_number": sendNumber,
//         "send_date": sendDate,
//         "send_destination": sendDestination,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "user": user.toJson(),
//       };
// }
//
// enum Body { ANY_TEXT, ANY_TEXT2 }
//
// final bodyValues =
//     EnumValues({"any text": Body.ANY_TEXT, "any text2": Body.ANY_TEXT2});
//
// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.image,
//     required this.emailVerifiedAt,
//     required this.roleId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   int id;
//   UserName name;
//   Email email;
//   dynamic image;
//   DateTime emailVerifiedAt;
//   String roleId;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: userNameValues.map[json["name"]]!,
//         email: emailValues.map[json["email"]]!,
//         image: json["image"],
//         emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
//         roleId: json["role_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": userNameValues.reverse[name],
//         "email": emailValues.reverse[email],
//         "image": image,
//         "email_verified_at": emailVerifiedAt.toIso8601String(),
//         "role_id": roleId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
//
// enum Email { SCHULIST_JUDAH_EXAMPLE_ORG, KIRSTEN81_EXAMPLE_ORG }
//
// final emailValues = EnumValues({
//   "kirsten81@example.org": Email.KIRSTEN81_EXAMPLE_ORG,
//   "schulist.judah@example.org": Email.SCHULIST_JUDAH_EXAMPLE_ORG
// });
//
// enum UserName { MR_HOBART_BOYLE_IV, MARGIE_HEATHCOTE_MD }
//
// final userNameValues = EnumValues({
//   "Margie Heathcote MD": UserName.MARGIE_HEATHCOTE_MD,
//   "Mr. Hobart Boyle IV": UserName.MR_HOBART_BOYLE_IV
// });
//
// enum Description { THIS_IS_DESCRIPTION_OF_TEST_SUBJECT, AB, GHGHG }
//
// final descriptionValues = EnumValues({
//   "ab": Description.AB,
//   "ghghg": Description.GHGHG,
//   "This is description of test subject":
//       Description.THIS_IS_DESCRIPTION_OF_TEST_SUBJECT
// });
//
// class Sender {
//   Sender({
//     required this.id,
//     required this.name,
//     required this.mobile,
//     required this.address,
//     required this.categoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.category,
//   });
//
//   int id;
//   SenderName name;
//   Mobile mobile;
//   Address address;
//   String categoryId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Category category;
//
//   factory Sender.fromJson(Map<String, dynamic> json) => Sender(
//         id: json["id"],
//         name: senderNameValues.map[json["name"]]!,
//         mobile: mobileValues.map[json["mobile"]]!,
//         address: addressValues.map[json["address"]]!,
//         categoryId: json["category_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         category: Category.fromJson(json["category"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": senderNameValues.reverse[name],
//         "mobile": mobileValues.reverse[mobile],
//         "address": addressValues.reverse[address],
//         "category_id": categoryId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "category": category.toJson(),
//       };
// }
//
// enum Address { THE_2169_BECHTELAR_MOUNTAINS_KENDALLBURY_NJ_995349126 }
//
// final addressValues = EnumValues({
//   "2169 Bechtelar Mountains\nKendallbury, NJ 99534-9126":
//       Address.THE_2169_BECHTELAR_MOUNTAINS_KENDALLBURY_NJ_995349126
// });
//
// class Category {
//   Category({
//     required this.id,
//     required this.name,
//     required this.createdAt,
//     required this.updatedAt,
//     this.pivot,
//   });
//
//   int id;
//   CategoryName name;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Pivot? pivot;
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: categoryNameValues.map[json["name"]]!,
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": categoryNameValues.reverse[name],
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "pivot": pivot?.toJson(),
//       };
// }
//
// enum CategoryName { OFFICIAL_ORGANIZATIONS, NEW_TAG, TEST }
//
// final categoryNameValues = EnumValues({
//   "new tag": CategoryName.NEW_TAG,
//   "Official Organizations": CategoryName.OFFICIAL_ORGANIZATIONS,
//   "test": CategoryName.TEST
// });
//
// class Pivot {
//   Pivot({
//     required this.mailId,
//     required this.tagId,
//   });
//
//   String mailId;
//   String tagId;
//
//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//         mailId: json["mail_id"],
//         tagId: json["tag_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "mail_id": mailId,
//         "tag_id": tagId,
//       };
// }
//
// enum Mobile { THE_7852234432 }
//
// final mobileValues = EnumValues({"785-223-4432": Mobile.THE_7852234432});
//
// enum SenderName { PROF_IZAIAH_HICKLE_I }
//
// final senderNameValues =
//     EnumValues({"Prof. Izaiah Hickle I": SenderName.PROF_IZAIAH_HICKLE_I});
//
// class Status {
//   Status({
//     required this.id,
//     required this.name,
//     required this.color,
//   });
//
//   int id;
//   StatusName name;
//   Color color;
//
//   factory Status.fromJson(Map<String, dynamic> json) => Status(
//         id: json["id"],
//         name: statusNameValues.map[json["name"]]!,
//         color: colorValues.map[json["color"]]!,
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": statusNameValues.reverse[name],
//         "color": colorValues.reverse[color],
//       };
// }
//
// enum Color { THE_0_XFFFA3_A57, THE_0_XFFFFE120 }
//
// final colorValues = EnumValues({
//   "0xfffa3a57": Color.THE_0_XFFFA3_A57,
//   "0xffffe120": Color.THE_0_XFFFFE120
// });
//
// enum StatusName { INBOX, PENDING }
//
// final statusNameValues =
//     EnumValues({"Inbox": StatusName.INBOX, "Pending": StatusName.PENDING});
//
// class Link {
//   Link({
//     this.url,
//     required this.label,
//     required this.active,
//   });
//
//   String? url;
//   String label;
//   bool active;
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//       };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
