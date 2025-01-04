class DetailServiceModel {
  String idKategori;
  String id;
  String namaItem;
  String kmTarget;
  String bulanTarget;
  String tahunTarget;
  String kondisiFisik;
  String quantity;
  String selectedOption; // 'cek', 'repair', atau 'ganti'

  DetailServiceModel({
    required this.idKategori,
    required this.id,
    required this.namaItem,
    required this.kmTarget,
    required this.bulanTarget,
    required this.tahunTarget,
    required this.kondisiFisik,
    required this.quantity,
    this.selectedOption = '0', // Default kosong
  });

  factory DetailServiceModel.fromJson(Map<String, dynamic> json) {
    return DetailServiceModel(
        idKategori: json['id_kategori'],
        id: json['id'],
        namaItem: json['nama_item'],
        kmTarget: json['km_target'],
        bulanTarget: json['monthly_target'],
        tahunTarget: json['yearly_target'],
        kondisiFisik: json['physical_condition'],
        quantity: json['quantity']);
  }
}
