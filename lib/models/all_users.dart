import 'dart:convert';

AllUsers allUsersFromJson(String str) => AllUsers.fromJson(json.decode(str));

String allUsersToJson(AllUsers data) => json.encode(data.toJson());

class AllUsers {
  AllUsers({
    required this.users,
  });

  List<User> users;

  factory AllUsers.fromJson(Map<String, dynamic> json) => AllUsers(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
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
    required this.role,
  });

  int id;
  String name;
  String email;
  dynamic image;
  DateTime? emailVerifiedAt;
  String roleId;
  DateTime createdAt;
  DateTime updatedAt;
  Role role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        roleId: json["role_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "role_id": roleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role": role.toJson(),
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  Name name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Name { GUEST, USER, ADMIN }

final nameValues =
    EnumValues({"admin": Name.ADMIN, "guest": Name.GUEST, "user": Name.USER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
