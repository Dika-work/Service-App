class MasterTypeItemModel {
  String id;
  String typeItem;

  MasterTypeItemModel({
    required this.id,
    required this.typeItem,
  });

  factory MasterTypeItemModel.fromJson(Map<String, dynamic> json) {
    return MasterTypeItemModel(
      id: json['id_type'],
      typeItem: json['type_item'],
    );
  }
}
