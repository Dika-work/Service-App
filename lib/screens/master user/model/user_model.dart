class UserModel {
  String username;
  String typeUser;

  UserModel({
    required this.username,
    required this.typeUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      typeUser: json['type_user'],
    );
  }
}
