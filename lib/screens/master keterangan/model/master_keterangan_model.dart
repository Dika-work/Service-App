class MasterKeteranganModel {
  String idKeterangan;
  String namaItem;
  String keterangan;

  MasterKeteranganModel({
    required this.idKeterangan,
    required this.namaItem,
    required this.keterangan,
  });

  factory MasterKeteranganModel.fromJson(Map<String, dynamic> json) {
    return MasterKeteranganModel(
      idKeterangan: json['id_ket'],
      namaItem: json['nama_item'],
      keterangan: json['keterangan'],
    );
  }
}
