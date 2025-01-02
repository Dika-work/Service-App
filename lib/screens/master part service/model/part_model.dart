class PartModel {
  String id;
  String namaItem;
  String typeItem;

  PartModel({
    required this.id,
    required this.namaItem,
    required this.typeItem,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
        id: json['id_kategori'],
        namaItem: json['nama_item'],
        typeItem: json['type_item']);
  }
}
