import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:get/get.dart';

import '../../../utils/loadings/snackbar.dart';
import '../model/part_model.dart';

class PartController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  RxList<PartModel> partModel = <PartModel>[].obs;
  final TextEditingController namaItemC = TextEditingController();
  final TextEditingController typeC = TextEditingController();
  RxString selectedKategoriName = ''.obs;

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
      final response = await _dio.get('/get-part');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        partModel.value = data.map((e) => PartModel.fromJson(e)).toList();
        print('ini response user : ${partModel.toList()}');
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

  createPart() async {
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    try {
      diomultipart.FormData formData = diomultipart.FormData.fromMap({
        'nama_item': namaItemC.text.trim(),
        'type_item': typeC.text.trim().toLowerCase(),
      });

      final response = await _dio.post('/create-part', data: formData);

      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        await getData();
        namaItemC.clear();
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

  deletePart(String id) async {
    isLoading.value = true;
    try {
      final response =
          await _dio.delete('/delete-part', data: {"id_kategori": id});

      if (response.statusCode == 200) {
        await getData();
        SnackbarLoader.successSnackBar(
          title: 'Berhasil',
          message: response.data['message'] ?? 'Part service berhasil dihapus',
        );
        Navigator.of(Get.overlayContext!).pop();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: response.data['message'] ??
              'Gagal menghapus part service yang dipilih',
        );
      }
    } catch (e) {
      SnackbarLoader.errorSnackBar(
        title: 'Kesalahan',
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  updatePart({
    required String id,
    required String namaItem,
    required String typeItem,
  }) async {
    isLoading.value = true;

    try {
      final data = {
        'id_kategori': id,
        'nama_item': namaItem,
        'type_item': typeItem,
      };

      print('Data yang akan dikirim untuk update: $data'); // Debugging

      final response = await _dio.put(
        '/edit-part',
        data: data,
      );

      if (response.statusCode == 200) {
        Get.back();
        SnackbarLoader.successSnackBar(
          title: 'Sukses',
          message: 'Part master diperbarui.',
        );
        await getData();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: response.data['message'] ?? 'Terjadi kesalahan.',
        );
      }
    } catch (e) {
      SnackbarLoader.errorSnackBar(
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
