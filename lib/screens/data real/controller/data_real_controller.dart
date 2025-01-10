import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;

import '../../../utils/loadings/snackbar.dart';
import '../model/data_real_model.dart';

class DataRealController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<DataRealModel> realModel = <DataRealModel>[].obs;

  List<TextEditingController> kmRealControllers = [];
  List<TextEditingController> waktuBulanRealControllers = [];
  List<TextEditingController> kondisiFisikRealControllers = [];
  List<TextEditingController> qtyRealControllers = [];
  List<TextEditingController> keteranganControllers = [];

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://192.168.1.4:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<void> getData(String idMtc) async {
    isLoading.value = true;

    try {
      final data = {'id_mtc': idMtc};

      final response = await _dio.get('/get-transaksi', data: data);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        realModel.value = data.map((e) => DataRealModel.fromJson(e)).toList();

        // Inisialisasi TextEditingController sesuai dengan jumlah data
        kmRealControllers =
            List.generate(realModel.length, (_) => TextEditingController());
        waktuBulanRealControllers =
            List.generate(realModel.length, (_) => TextEditingController());
        kondisiFisikRealControllers =
            List.generate(realModel.length, (_) => TextEditingController());
        qtyRealControllers =
            List.generate(realModel.length, (_) => TextEditingController());
        keteranganControllers =
            List.generate(realModel.length, (_) => TextEditingController());
      }
    } on diomultipart.DioException catch (e) {
      SnackbarLoader.warningSnackBar(
        title: 'Error',
        message: e.response?.data['message'] ?? 'Terjadi kesalahan',
      );
      print('INI ERROR SAAT DI DATA REAL: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTransaksi() async {
    isLoading.value = true;

    try {
      // List untuk menyimpan data setiap item
      List<Map<String, dynamic>> transaksiData = [];

      // Iterasi melalui semua item di realModel
      for (int i = 0; i < realModel.length; i++) {
        final data = realModel[i];

        // Validasi input hanya jika statusService != '1'
        if (data.statusService == '4') {
          if (kmRealControllers[i].text.isEmpty ||
              waktuBulanRealControllers[i].text.isEmpty ||
              kondisiFisikRealControllers[i].text.isEmpty ||
              qtyRealControllers[i].text.isEmpty ||
              keteranganControllers[i].text.isEmpty) {
            Get.snackbar('Error', 'Semua field yang diperlukan harus diisi.');
            return; // Hentikan eksekusi jika ada field yang kosong
          }
        }

        // Tambahkan data ke list transaksiData
        transaksiData.add({
          'id_transaksi': data.idTransaksi,
          'id_mtc': data.idMtc,
          'km_real':
              data.statusService != '1' ? kmRealControllers[i].text : '-',
          'monthly_real': data.statusService != '1'
              ? waktuBulanRealControllers[i].text
              : '-',
          'physical_condition_real': data.statusService != '1'
              ? kondisiFisikRealControllers[i].text
              : '-',
          'quantity_real':
              data.statusService != '1' ? qtyRealControllers[i].text : '-',
          'keterangan': keteranganControllers[i].text,
        });
      }

      final data = {
        'transaksi': transaksiData,
      };

      // Kirim data ke server
      final response = await _dio.put(
        '/update-transaksi-real',
        data: data,
        options: diomultipart.Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Log response untuk debugging
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        Get.back(result: true);
        SnackbarLoader.successSnackBar(
            title: 'Berhasil', message: 'Service berkala berhasil terkirim');
      } else {
        SnackbarLoader.warningSnackBar(
            title: 'Error',
            message: 'Gagal memperbarui transaksi: ${response.data}');
      }
    } on diomultipart.DioException catch (e) {
      SnackbarLoader.errorSnackBar(
          title: 'Error',
          message:
              e.response?.data['message'] ?? 'Gagal memperbarui transaksi');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTransaksiDetailSb(String idMtc) async {
    isLoading.value = true;

    try {
      // Pastikan realModel tidak kosong
      if (realModel.isEmpty) {
        SnackbarLoader.warningSnackBar(
            title: 'Error', message: 'Tidak ada data untuk diperbarui.');
        return;
      }

      // List untuk menyimpan data setiap item
      List<Map<String, dynamic>> transaksiData = [];

      // Iterasi dan ambil status terbaru dari realModel
      for (final data in realModel) {
        transaksiData.add({
          'id_transaksi': data.idTransaksi, // Pastikan id_transaksi ada
          'status_service': data.statusService, // Gunakan status terbaru
        });
      }

      final requestData = {
        'id_mtc': idMtc,
        'data': transaksiData,
      };

      // Kirim request PUT ke server
      final response = await _dio.put(
        '/update-status-service',
        data: requestData,
        options: diomultipart.Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Log response untuk debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        Get.back(result: true);
        SnackbarLoader.successSnackBar(
            title: 'Berhasil', message: 'Data berhasil diperbarui.');
      } else {
        SnackbarLoader.warningSnackBar(
            title: 'Error',
            message: 'Gagal memperbarui transaksi: ${response.data}');
      }
    } on diomultipart.DioException catch (e) {
      // Tangani error jika ada
      print('DioException: ${e.message}');
      print('DioException Response: ${e.response?.data}');
      SnackbarLoader.errorSnackBar(
          title: 'Error',
          message:
              e.response?.data['message'] ?? 'Gagal memperbarui transaksi');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Membersihkan TextEditingController saat controller ditutup
    for (var controller in kmRealControllers) {
      controller.dispose();
    }
    for (var controller in waktuBulanRealControllers) {
      controller.dispose();
    }
    for (var controller in kondisiFisikRealControllers) {
      controller.dispose();
    }
    for (var controller in qtyRealControllers) {
      controller.dispose();
    }
    for (var controller in keteranganControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
