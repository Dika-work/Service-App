class SatuanModel {
  String idSatuan;
  String namaSatuan;
  String singkatan;

  SatuanModel({
    required this.idSatuan,
    required this.namaSatuan,
    required this.singkatan,
  });

  factory SatuanModel.fromJson(Map<String, dynamic> json) {
    return SatuanModel(
      idSatuan: json['id_satuan'],
      namaSatuan: json['nama_satuan'],
      singkatan: json['singkatan'],
    );
  }
}
