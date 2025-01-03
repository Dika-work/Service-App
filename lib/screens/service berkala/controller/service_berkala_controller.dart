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
}
