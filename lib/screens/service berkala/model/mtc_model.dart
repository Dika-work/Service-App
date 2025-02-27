class MtcModel {
  String id;
  String mekanik;
  String kpool;
  String noPolisi;
  String lastService;
  String nowKm;
  String nextService;
  String jenisKen;
  String merkKen;
  String typeKen;
  String driver;
  String noBuntut;
  String status;
  String createAt;

  MtcModel({
    required this.id,
    required this.mekanik,
    required this.kpool,
    required this.noPolisi,
    required this.lastService,
    required this.nowKm,
    required this.nextService,
    required this.jenisKen,
    required this.merkKen,
    required this.typeKen,
    required this.driver,
    required this.noBuntut,
    required this.status,
    required this.createAt,
  });

  factory MtcModel.fromJson(Map<String, dynamic> json) {
    return MtcModel(
      id: json['id_mtc'],
      mekanik: json['mekanik'],
      kpool: json['kpool'],
      noPolisi: json['no_polisi'],
      lastService: json['last_service'],
      nowKm: json['now_km'],
      nextService: json['next_service'],
      jenisKen: json['jenis_ken'],
      merkKen: json['merk_ken'],
      typeKen: json['type_ken'],
      driver: json['driver'],
      noBuntut: json['no_buntut'],
      status: json['status'],
      createAt: json['created_at'],
    );
  }
}
