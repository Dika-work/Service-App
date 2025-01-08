class DataRealModel {
  String idTransaksi;
  String idMtc;
  String mekanik;
  String deskripsiPengecekan;
  String kmTarget;
  String bulanTarget;
  String tahunTarget;
  String kondisiFisik;
  String quantity;
  String statusService;

  DataRealModel({
    required this.idTransaksi,
    required this.idMtc,
    required this.mekanik,
    required this.deskripsiPengecekan,
    required this.kmTarget,
    required this.bulanTarget,
    required this.tahunTarget,
    required this.kondisiFisik,
    required this.quantity,
    required this.statusService,
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
      kondisiFisik: json['kondisi_fisik'],
      quantity: json['quantity'],
      statusService: json['status_service'],
    );
  }
}
