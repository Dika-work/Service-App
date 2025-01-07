class TransaksiServiceModel {
  String idTransaksi;
  String idKategori;
  String idDetailKategori;
  String statusService;
  String namaMekanik;
  String tglInput;
  String kmReal;
  String bulanReal;
  String kondisiFisik;
  String keterangan;

  TransaksiServiceModel({
    required this.idTransaksi,
    required this.idKategori,
    required this.idDetailKategori,
    required this.statusService,
    required this.namaMekanik,
    required this.tglInput,
    required this.kmReal,
    required this.bulanReal,
    required this.kondisiFisik,
    required this.keterangan,
  });

  factory TransaksiServiceModel.fromJson(Map<String, dynamic> json) {
    return TransaksiServiceModel(
        idTransaksi: json['id_transaksi'],
        idKategori: json['id_kategori'],
        idDetailKategori: json['id_detail_kategori'],
        statusService: json['status_service'],
        namaMekanik: json['nama_mekanik'],
        tglInput: json['tgl_input'],
        kmReal: json['km_real'],
        bulanReal: json['monthly_real'],
        kondisiFisik: json['physical_condition_real'],
        keterangan: json['keterangan']);
  }
}
