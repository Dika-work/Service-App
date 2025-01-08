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
      baseUrl: 'http://10.3.80.4:8080',
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
        // Validasi input
        if (kmRealControllers[i].text.isEmpty ||
            waktuBulanRealControllers[i].text.isEmpty ||
            kondisiFisikRealControllers[i].text.isEmpty ||
            qtyRealControllers[i].text.isEmpty ||
            keteranganControllers[i].text.isEmpty) {
          Get.snackbar('Error', 'Semua field harus diisi.');
          return; // Hentikan eksekusi jika ada field yang kosong
        }

        try {
          transaksiData.add({
            'id_transaksi': realModel[i].idTransaksi,
            'id_mtc': realModel[i].idMtc,
            'km_real': kmRealControllers[i].text,
            'monthly_real': waktuBulanRealControllers[i].text,
            'physical_condition_real': kondisiFisikRealControllers[i].text,
            'quantity_real': qtyRealControllers[i].text,
            'keterangan': keteranganControllers[i].text,
          });
          print('ID Transaksi: ${realModel[i].idTransaksi}');
          print('ID Mtc: ${realModel[i].idMtc}');
          print('KM Real: ${kmRealControllers[i].text}');
          print('Monthly Real: ${waktuBulanRealControllers[i].text}');
          print('Physical Condition: ${kondisiFisikRealControllers[i].text}');
          print('Quantity Real: ${qtyRealControllers[i].text}');
          print('Keterangan: ${keteranganControllers[i].text}');
        } catch (e) {
          Get.snackbar('Error', 'Input tidak valid: ${e.toString()}');
          return; // Hentikan eksekusi jika parsing gagal
        }
      }

      final data = {
        'transaksi': transaksiData,
      };

      // Pastikan Content-Type yang benar untuk JSON
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
        Get.snackbar('Berhasil', 'Data transaksi berhasil diperbarui');
      } else {
        Get.snackbar('Error', 'Gagal memperbarui transaksi: ${response.data}');
      }
    } on diomultipart.DioException catch (e) {
      Get.snackbar('Error',
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
