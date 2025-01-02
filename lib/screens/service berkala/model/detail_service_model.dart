class DetailServiceModel {
  String id;
  String namaItem;
  String kmTarget;
  String bulanTarget;
  String tahunTarget;
  String kondisiFisik;
  String quantity;

  DetailServiceModel({
    required this.id,
    required this.namaItem,
    required this.kmTarget,
    required this.bulanTarget,
    required this.tahunTarget,
    required this.kondisiFisik,
    required this.quantity,
  });

  factory DetailServiceModel.fromJson(Map<String, dynamic> json) {
    return DetailServiceModel(
        id: json['id'],
        namaItem: json['nama_item'],
        kmTarget: json['km_target'],
        bulanTarget: json['monthly_target'],
        tahunTarget: json['yearly_target'],
        kondisiFisik: json['physical_condition'],
        quantity: json['quantity']);
  }
}
