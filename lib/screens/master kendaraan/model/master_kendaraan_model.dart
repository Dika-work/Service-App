class MasterKendaraanModel {
  String idJenisKen;
  String jenisKen;
  String merk;
  String type;

  MasterKendaraanModel({
    required this.idJenisKen,
    required this.jenisKen,
    required this.merk,
    required this.type,
  });

  factory MasterKendaraanModel.fromJson(Map<String, dynamic> json) {
    return MasterKendaraanModel(
      idJenisKen: json['id_jenis_ken'],
      jenisKen: json['jenis_ken'],
      merk: json['merk'],
      type: json['type'],
    );
  }
}
