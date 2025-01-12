class DataRealModel {
  String idTransaksi;
  String idMtc;
  String mekanik;
  String deskripsiPengecekan;
  String kmTarget;
  String bulanTarget;
  String tahunTarget;
  String kondisiFisikBagus;
  String kondisiFisikJelek;
  String quantity;
  String statusService;
  String keteranganService;

  DataRealModel({
    required this.idTransaksi,
    required this.idMtc,
    required this.mekanik,
    required this.deskripsiPengecekan,
    required this.kmTarget,
    required this.bulanTarget,
    required this.tahunTarget,
    required this.kondisiFisikBagus,
    required this.kondisiFisikJelek,
    required this.quantity,
    required this.statusService,
    required this.keteranganService,
  });

  factory DataRealModel.fromJson(Map<String, dynamic> json) {
    return DataRealModel(
      idTransaksi: json['id_transaksi'],
      idMtc: json['id_mtc'],
      mekanik: json['mekanik'],
      deskripsiPengecekan: json['deskripsi_pengecekan'],
      kmTarget: json['km_target'],
      bulanTarget: json['bulan_target'],
      tahunTarget: json['tahun_target'],
      kondisiFisikBagus: json['kondisi_fisik_bagus'],
      kondisiFisikJelek: json['kondisi_fisik_jelek'],
      quantity: json['quantity'],
      statusService: json['status_service'],
      keteranganService: json['keterangan_service'],
    );
  }
}
