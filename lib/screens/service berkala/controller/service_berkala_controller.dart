import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:service/routes/app_pages.dart';

import '../../../utils/loadings/snackbar.dart';
import '../model/detail_service_model.dart';
import '../model/mtc_model.dart';
// import '../model/transaksi_service_model.dart';

class ServiceBerkalaController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final localStorage = GetStorage();

  RxList<DetailServiceModel> detailServiceModel = <DetailServiceModel>[].obs;
  RxList<MtcModel> mtcModel = <MtcModel>[].obs;
  // RxList<TransaksiServiceModel> transaksiServiceModel = <TransaksiServiceModel>[].obs;

  final TextEditingController kmTargetC = TextEditingController();
  final TextEditingController bulanTargetC = TextEditingController();
  final TextEditingController tahunTargetC = TextEditingController();
  final TextEditingController kondisiFisikC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

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
        'physical_condition': kondisiFisikC.text.trim().toLowerCase(),
        'quantity': qtyC.text.trim().toLowerCase(),
      });

      final response = await _dio.post('/detail-service', data: formData);

      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        await getData();
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

  updateDetailService({
    required String id,
    required String namaItem,
    required String kmTarget,
    required String bulanTarget,
    required String tahunTarget,
    required String kondisiFisik,
    required String quantity,
  }) async {
    isLoading.value = true;

    try {
      final data = {
        'nama_item': namaItem,
        'km_target': kmTarget,
        'monthly_target': bulanTarget,
        'yearly_target': tahunTarget,
        'physical_condition': kondisiFisik,
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

  // getDataService() async {
  //   isLoading.value = true;

  //   try {
  //     final response = await _dio.get('/service');

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data['data'];
  //       mtcModel.value = data.map((e) => MtcModel.fromJson(e)).toList();
  //       print('ini response user : ${mtcModel.toList()}');
  //     }
  //   } on diomultipart.DioException catch (e) {
  //     SnackbarLoader.warningSnackBar(
  //       title: 'Error',
  //       message: e.response?.data['message'] ?? 'Terjadi kesalahan',
  //     );

  //     print(
  //         'Error getAllUser: ${e.response?.data['message'] ?? 'Terjadi kesalahan'}');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  createTransaksiService(String idMtc) async {
    // Validasi apakah semua radio button sudah dipilih
    bool allSelected =
        detailServiceModel.every((item) => item.selectedOption != '0');

    if (!allSelected) {
      SnackbarLoader.errorSnackBar(
        title: 'Oops',
        message: 'Harap mengisi semua pilihan sebelum melanjutkan.',
      );
      return; // Hentikan eksekusi jika ada yang belum dipilih
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

      print('Transaksi Data: $transaksiData'); // Log the data being sent

      final response =
          await _dio.post('/create-transaksi', data: {'data': transaksiData});

      if (response.statusCode == 201) {
        SnackbarLoader.successSnackBar(
          title: 'Sukses',
          message: 'Transaksi berhasil dibuat.',
        );
        Get.offAndToNamed(Routes.HOME_MEKANIK, result: true);
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
