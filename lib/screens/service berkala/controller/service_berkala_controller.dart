import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../utils/loadings/snackbar.dart';
import '../model/detail_service_model.dart';

class ServiceBerkalaController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final localStorage = GetStorage();

  RxList<DetailServiceModel> detailServiceModel = <DetailServiceModel>[].obs;

  final TextEditingController kmTargetC = TextEditingController();
  final TextEditingController bulanTargetC = TextEditingController();
  final TextEditingController tahunTargetC = TextEditingController();
  final TextEditingController kondisiFisikBagusC = TextEditingController();
  final TextEditingController kondisiFisikJelekC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final TextEditingController satuanQtyC = TextEditingController();

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://10.3.80.4:8080',
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

  createDetailService(String kategoryId, String selectedKategoryId) async {
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    if (selectedKategoryId == '') {
      isLoading.value = false;
      SnackbarLoader.errorSnackBar(
          title: 'Oops', message: 'Kategori item harus di isi');
      return;
    }

    try {
      diomultipart.FormData formData = diomultipart.FormData.fromMap({
        'nama_item': kategoryId,
        'km_target': kmTargetC.text.trim().toLowerCase(),
        'monthly_target': bulanTargetC.text.trim().toLowerCase(),
        'yearly_target': tahunTargetC.text.trim().toLowerCase(),
        'physical_condition_bagus':
            kondisiFisikBagusC.text.trim().toLowerCase(),
        'physical_condition_jelek':
            kondisiFisikJelekC.text.trim().toLowerCase(),
        'quantity': qtyC.text.trim().toLowerCase(),
        'satuan': satuanQtyC.text.trim().toLowerCase(),
      });

      final response = await _dio.post('/detail-service', data: formData);

      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        await getData();
        kmTargetC.clear();
        bulanTargetC.clear();
        tahunTargetC.clear();
        kondisiFisikBagusC.clear();
        kondisiFisikJelekC.clear();
        qtyC.clear();
        satuanQtyC.clear();
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

  updateDetailService({
    required String id,
    required String namaItem,
    required String kmTarget,
    required String bulanTarget,
    required String tahunTarget,
    required String kondisiFisikBagus,
    required String kondisiFisikJelek,
    required String quantity,
  }) async {
    isLoading.value = true;

    try {
      final data = {
        'nama_item': namaItem,
        'km_target': kmTarget,
        'monthly_target': bulanTarget,
        'yearly_target': tahunTarget,
        'physical_condition_bagus': kondisiFisikBagus,
        'physical_condition_jelek': kondisiFisikJelek,
        'quantity': quantity,
      };

      final response = await _dio.put('/detail-service/$id', data: data);

      if (response.statusCode == 200) {
        Get.back();
        SnackbarLoader.successSnackBar(
          title: 'Sukses',
          message: 'Detail service berkala diperbarui.',
        );
        await getData(); // Ambil data terbaru setelah update
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

  deleteDetailService(String id) async {
    isLoading.value = true;
    try {
      final response = await _dio.delete('/detail-service/$id');

      if (response.statusCode == 200) {
        await getData();
        SnackbarLoader.successSnackBar(
          title: 'Berhasil',
          message:
              response.data['message'] ?? 'Detail service berhasil dihapus',
        );
        Navigator.of(Get.overlayContext!).pop();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: response.data['message'] ??
              'Gagal menghapus detail service yang dipilih',
        );
      }
    } catch (e) {
      SnackbarLoader.errorSnackBar(
        title: 'Oops',
        message: 'Terjadi kesalahan: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  createTransaksiService(String idMtc) async {
    // Validasi apakah semua radio button sudah dipilih
    bool allSelected =
        detailServiceModel.every((item) => item.selectedOption != '0');

    if (!allSelected) {
      SnackbarLoader.errorSnackBar(
        title: 'Oops',
        message: 'Harap mengisi semua pilihan sebelum melanjutkan.',
      );
      return;
    }

    isLoading.value = true;
    try {
      String namaMekanik = localStorage.read('username');
      print('Mekanik: $namaMekanik');

      List<Map<String, dynamic>> transaksiData = detailServiceModel.map((item) {
        return {
          'id_mtc': idMtc,
          'id_detail_kategori': item.id,
          'status_service': item.selectedOption,
          'nama_mekanik': namaMekanik,
          'tgl_input': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          'status': '1'
        };
      }).toList();

      print('Transaksi Data: $transaksiData');

      final response =
          await _dio.post('/create-transaksi', data: {'data': transaksiData});

      if (response.statusCode == 201) {
        Get.back(result: true);
        SnackbarLoader.successSnackBar(
          title: 'Sukses',
          message: 'Transaksi berhasil dibuat.',
        );
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
      print('ERROR CREATE TRANSAKSI SERVICE: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
