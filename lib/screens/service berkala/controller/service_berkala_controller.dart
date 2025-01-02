import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;

import '../../../utils/loadings/snackbar.dart';
import '../model/detail_service_model.dart';

class ServiceBerkalaController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  RxList<DetailServiceModel> detailServiceModel = <DetailServiceModel>[].obs;
  final TextEditingController namaItemC = TextEditingController();
  final TextEditingController kmTargetC = TextEditingController();
  final TextEditingController bulanTargetC = TextEditingController();
  final TextEditingController tahunTargetC = TextEditingController();
  final TextEditingController kondisiFisikC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://10.3.80.254:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isLoading.value = true;

    try {
      final response = await _dio.get('/detail-service');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        detailServiceModel.value =
            data.map((e) => DetailServiceModel.fromJson(e)).toList();
        print('ini response user : ${detailServiceModel.toList()}');
      }
    } on diomultipart.DioException catch (e) {
      SnackbarLoader.warningSnackBar(
        title: 'Error',
        message: e.response?.data['message'] ?? 'Terjadi kesalahan',
      );

      print(
          'Error getAllUser: ${e.response?.data['message'] ?? 'Terjadi kesalahan'}');
    } finally {
      isLoading.value = false;
    }
  }

  createDetailService() async {
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    try {
      diomultipart.FormData formData = diomultipart.FormData.fromMap({
        'nama_item': namaItemC.text.trim(),
        'km_target': kmTargetC.text.trim().toLowerCase(),
        'monthly_target': bulanTargetC.text.trim().toLowerCase(),
        'yearly_target': tahunTargetC.text.trim().toLowerCase(),
        'physical_condition': kondisiFisikC.text.trim().toLowerCase(),
        'quantity': qtyC.text.trim().toLowerCase(),
      });

      final response = await _dio.post('/detail-service', data: formData);

      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        await getData();
        namaItemC.clear();
        kmTargetC.clear();
        bulanTargetC.clear();
        tahunTargetC.clear();
        kondisiFisikC.clear();
        qtyC.clear();
        SnackbarLoader.successSnackBar(
            title: 'Berhasil', message: 'Data berhasil ditambahkan');
      }
    } catch (e) {
      SnackbarLoader.errorSnackBar(
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
      );
      print('ERROR CREATE SERVICE BERKALA : $e');
    } finally {
      isLoading.value = false;
    }
  }

  // var selectedPelumas = ''.obs;
  // var selectedFilter = ''.obs;
  // var selectedMesin = ''.obs;
  // var selectedDinamo = ''.obs;
  // var selectedKopling = ''.obs;
  // var selectedAccu = ''.obs;
  // var selectedPtoHidrolik = ''.obs;
  // var selectedAccesories = ''.obs;
  // var selectedKacaSpion = ''.obs;
  // var selectedKacaFilm = ''.obs;

  // final List<String> pelumas = [
  //   'Oli Mesin',
  //   'Oli Matic',
  //   'Oli Transmisi',
  //   'Oli Gardan',
  //   'Oli Power Steering',
  //   'Oli Hidrolik',
  //   'Minyak Rem',
  //   'Gemuk',
  //   'Grease Temp',
  // ];

  // final List<String> filter = [
  //   'Filter Oli',
  //   'Filter Udara',
  //   'Filter Solar Atas',
  //   'Filter Solar Bawah'
  // ];

  // final List<String> mesin = [
  //   'Valve Rem',
  //   'Pedal Valve Rem',
  //   'Kampas Rem Depan',
  //   'Kampas Rem Belakang',
  //   'Per Rem',
  //   'Wheel Cylinder',
  //   'Servo Rem',
  //   'Air MAster Rem Angin',
  //   'Selang Spiral Angin',
  //   'Rem Angin',
  //   'Karet Jember',
  //   'Selang Teflon Rem Angin',
  //   'Selang Pipa Minyak Rem',
  //   'Nepel Selang Rem Angin',
  //   'Selang Pipa Angin',
  // ];

  // final List<String> dinamo = [
  //   'Holder Brush',
  //   'York/Bantalan Bearing',
  //   'Bandix',
  //   'Busing',
  //   'Carbon Brush',
  //   'Bearing',
  //   'Rumah Bearing',
  //   'Breket Amateur',
  //   'Gulungan Motor Wipper',
  //   'Swith Relay',
  //   'Dinamo Stater',
  //   'Angker',
  //   'Otomatis Dinamo Stater (Switch)',
  //   'Dinamo Amper',
  //   'Gulungan',
  //   'Silicon',
  //   'Regulator',
  //   'Angker/Rotor',
  // ];

  // final List<String> kopling = [
  //   'Plat Kopling',
  //   'Deklaher',
  //   'Dekrup',
  //   'Master Kopling Atas',
  //   'Master Kopling Bawah',
  //   'Selang Pipa Minyak Kopling',
  //   'Selang Pipa Angin Kopling',
  //   'Toros Master Kopling Atas',
  //   'Toros Master Kopling Bawah',
  // ];

  // final List<String> accu = [
  //   'Accu',
  //   'Kepala Accu',
  //   'Air Accu',
  //   'Sekum Accu',
  //   'Kabel Pararel Accu (+/-)',
  //   'Kabel Masa Accu',
  // ];

  // final List<String> ptoHidrolik = [
  //   'PTO',
  //   'Planis (Sambungan Oli Hidrolik)',
  //   'Joint Kopel Hidrolik',
  //   'Sambungan PTO',
  //   'Bearing Belakang (Roller Selling Hidrolik)',
  //   'Boom Hidrolik',
  //   'Seling Hidrolik',
  //   'Pintu Hidrolik',
  //   'Bearing Hidrolik',
  //   'Kunci Lock Buntut Hidrolik',
  //   'Selang Sambungan Oli Hidrolik',
  //   'Coppler Selang Hidrolik',
  //   'Selang Pipa Hidrolik',
  //   'Kuku Macam Seling Hidrolik',
  //   'Roller Seling Hidrolik',
  //   'Tuas PTO Hidrolik',
  // ];

  // final List<String> accesories = [
  //   'Lampu Utama',
  //   'Lampu Senja',
  //   'Lampu LED/Lampu Kota',
  //   'Lampu Sen Depan Kanan Kiri',
  //   'Lampu Sen Belakang Kanan Kiri',
  //   'Lampu Tembak Depan',
  //   'Lampu Rotari',
  //   'Lampu Tembak Mundur',
  //   'Kabel Spiral Elektrik',
  //   'Alarm Mundur',
  //   'Sikring Lampu',
  //   'Rumah Sikring',
  //   'Relay Lampu',
  //   'Flaser Lampu',
  //   'Kabel Roll',
  //   'Sekun Kabel',
  // ];

  // final List<String> kacaSpion = [
  //   'Kaca Spion Kotak',
  //   'Kaca Spion Bulat',
  //   'Kaca Spion Kanan Kiri',
  //   'Tiang (Gagang Spion)'
  // ];

  // final List<String> kacaFilm = [
  //   'Kaca Film Depan',
  //   'Kaca Film Kanan Kiri',
  //   'Kaca Film Kanan Belakang',
  //   'Sekum Accu',
  //   'Kabel Pararel Accu (+/-)',
  //   'Kabel Masa Accu',
  // ];
}
