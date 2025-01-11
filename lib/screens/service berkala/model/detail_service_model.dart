class DetailServiceModel {
  String idKategori;
  String id;
  String namaItem;
  String kmTarget;
  String bulanTarget;
  String tahunTarget;
  String kondisiFisikBagus;
  String kondisiFisikJelek;
  String quantity;
  String satuan;
  String keterangan;
  String selectedOption; // 'cek', 'repair', atau 'ganti'

  DetailServiceModel({
    required this.idKategori,
    required this.id,
    required this.namaItem,
    required this.kmTarget,
    required this.bulanTarget,
    required this.tahunTarget,
    required this.kondisiFisikBagus,
    required this.kondisiFisikJelek,
    required this.quantity,
    required this.satuan,
    required this.keterangan,
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
      kondisiFisikBagus: json['physical_condition_bagus'],
      kondisiFisikJelek: json['physical_condition_jelek'],
      quantity: json['quantity'],
      satuan: json['satuan'],
      keterangan: json['keterangan'],
    );
  }
}
