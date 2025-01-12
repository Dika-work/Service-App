import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;

import '../../../utils/loadings/snackbar.dart';
import '../model/master_kendaraan_model.dart';

class MasterKendaraanController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<MasterKendaraanModel> masterKendaraanModel =
      <MasterKendaraanModel>[].obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController jenisKenC = TextEditingController();
  TextEditingController merkC = TextEditingController();
  TextEditingController typeC = TextEditingController();

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://192.168.1.4:8080',
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
      final response = await _dio.get(
        '/master-kendaraan',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        masterKendaraanModel.value =
            data.map((e) => MasterKendaraanModel.fromJson(e)).toList();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: 'Gagal mengambil data mekanik.',
        );
      }
    } on diomultipart.DioException catch (e) {
      SnackbarLoader.warningSnackBar(
        title: 'Error',
        message: e.response?.data['message'] ??
            'Terjadi kesalahan pada master jenis kendaraan',
      );
      print(
          'Error getData: ${e.response?.data['message'] ?? 'Terjadi kesalahan'}');
    } finally {
      isLoading.value = false;
    }
  }

  createJenisKendaraan() async {
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    try {
      diomultipart.FormData formData = diomultipart.FormData.fromMap({
        'jenis_ken': jenisKenC.text.trim(),
        'merk': merkC.text.trim(),
        'type': typeC.text.trim(),
      });

      final response = await _dio.post('/master-kendaraan', data: formData);

      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        await getData();
        jenisKenC.clear();
        merkC.clear();
        typeC.clear();
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
}
