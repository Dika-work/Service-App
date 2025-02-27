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

class KendaraanModelEksternal {
  String noPolisi;
  String supir;
  String kmNow;
  String lastKmService;

  KendaraanModelEksternal({
    required this.noPolisi,
    required this.supir,
    required this.kmNow,
    required this.lastKmService,
  });

  factory KendaraanModelEksternal.fromJson(Map<String, dynamic> json) {
    return KendaraanModelEksternal(
      noPolisi: json['no_polisi'],
      supir: json['supir'],
      kmNow: json['km'],
      lastKmService: json['km_sebelumnya'],
    );
  }
}
