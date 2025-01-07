class UserModel {
  String id;
  String username;
  String typeUser;

  UserModel({
    required this.id,
    required this.username,
    required this.typeUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      typeUser: json['type_user'],
    );
  }
}
