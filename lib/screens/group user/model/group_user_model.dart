class GroupUserModel {
  String id;
  String typeUser;
  String add;
  String edit;
  String delete;

  GroupUserModel({
    required this.id,
    required this.typeUser,
    required this.add,
    required this.edit,
    required this.delete,
  });

  factory GroupUserModel.fromJson(Map<String, dynamic> json) {
    return GroupUserModel(
      id: json['group_id'],
      typeUser: json['type_user'],
      add: json['can_add'],
      edit: json['can_edit'],
      delete: json['can_delete'],
    );
  }
}
