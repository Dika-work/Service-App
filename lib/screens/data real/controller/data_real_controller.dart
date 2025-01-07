import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;

import '../../../utils/loadings/snackbar.dart';
import '../model/data_real_model.dart';

class DataRealController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<DataRealModel> realModel = <DataRealModel>[].obs;

  final TextEditingController kmRealC = TextEditingController();
  final TextEditingController waktuBulanRealC = TextEditingController();
  final TextEditingController kondisiFisikRealC = TextEditingController();
  final TextEditingController qtyRealC = TextEditingController();
  final TextEditingController keteranganC = TextEditingController();

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://10.3.80.4:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  getData(String idMtc) async {
    isLoading.value = true;

    try {
      final data = {'id_mtc': idMtc};

      final response = await _dio.get('/get-transaksi', data: data);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        realModel.value = data.map((e) => DataRealModel.fromJson(e)).toList();
        print('ini response user : ${realModel.toList()}');
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
}
