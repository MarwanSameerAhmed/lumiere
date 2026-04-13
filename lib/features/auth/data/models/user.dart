enum UserRole { admin, user }

class UserModel {
  final String uId;
  final String name;
  final String email;
  final String? userImage;
  final UserRole role;
  final DateTime createAt;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    this.userImage,
    this.role = UserRole.user,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "uId": uId,
      "name": name,
      "email": email,
      "userImage": userImage,
      "role": role == UserRole.admin ? "admin" : "user",
      "createAt": createAt.toIso8601String(),
    };
  }

  factory UserModel.froMJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      name: json['name'],
      email: json['email'],
      userImage: json['userImage'],
      role: json["role"] == "admin" ? UserRole.admin : UserRole.user,
      createAt: json['createAt'] != null
          ? DateTime.parse(json["createAt"])
          : DateTime.now(),
    );
  }
}
