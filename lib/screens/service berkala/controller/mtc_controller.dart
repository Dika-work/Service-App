import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;

import '../../../utils/loadings/snackbar.dart';

class MtcController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  final TextEditingController mekanikC = TextEditingController();
  final TextEditingController kpoolC = TextEditingController();
  final TextEditingController noPolisiC = TextEditingController();
  final TextEditingController lastKmServiceC = TextEditingController();
  final TextEditingController nowKmServiceC = TextEditingController();
  final TextEditingController nextKmServiceC = TextEditingController();
  final TextEditingController jenisKenC = TextEditingController();
  final TextEditingController typeKenC = TextEditingController();
  final TextEditingController driverC = TextEditingController();
  final TextEditingController noBuntutC = TextEditingController();

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://10.3.80.254:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  createService() async {
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    try {
      diomultipart.FormData formData = diomultipart.FormData.fromMap({
        'mekanik': mekanikC.text.trim(),
        'kpool': kpoolC.text.trim(),
        'no_polisi': noPolisiC.text.trim(),
        'last_service': lastKmServiceC.text.trim(),
        'now_km': nowKmServiceC.text.trim(),
        'next_service': nextKmServiceC.text.trim(),
        'jenis_ken': jenisKenC.text.trim(),
        'type_ken': typeKenC.text.trim(),
        'driver': driverC.text.trim(),
        'no_buntut': noBuntutC.text.trim(),
      });

      final response = await _dio.post('/service', data: formData);

      if (response.statusCode == 201) {
        Get.back(result: true);
        mekanikC.clear();
        kpoolC.clear();
        noPolisiC.clear();
        lastKmServiceC.clear();
        nowKmServiceC.clear();
        nextKmServiceC.clear();
        jenisKenC.clear();
        typeKenC.clear();
        driverC.clear();
        noBuntutC.clear();
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
