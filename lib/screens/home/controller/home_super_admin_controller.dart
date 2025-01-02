import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:get_storage/get_storage.dart';
import 'package:service/routes/app_pages.dart';

import '../../../utils/loadings/snackbar.dart';
import '../../service berkala/model/service_model.dart';

class HomeSuperAdminController extends GetxController {
  final localStorage = GetStorage();
  RxString username = ''.obs;
  RxString typeUser = ''.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  RxList<ServiceModel> serviceModel = <ServiceModel>[].obs;
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

  @override
  void onInit() {
    super.onInit();
    getData();
    username.value = localStorage.read('username') ?? '';
    typeUser.value = localStorage.read('type_user') ?? '';
  }

  getData() async {
    isLoading.value = true;

    try {
      final response = await _dio.get('/service');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        serviceModel.value = data.map((e) => ServiceModel.fromJson(e)).toList();
        print('ini response user : ${serviceModel.toList()}');
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
        Navigator.of(Get.overlayContext!).pop();
        await getData();
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

  updateService({
    required String idMtc,
    required String mekanik,
    required String kpool,
    required String noPolisi,
    required String lastService,
    required String nowKm,
    required String nextService,
    required String jenisKen,
    required String typeKen,
    required String driver,
    required String noBuntut,
  }) async {
    isLoading.value = true;

    try {
      final data = {
        'mekanik': mekanik,
        'kpool': kpool,
        'no_polisi': noPolisi,
        'last_service': lastService,
        'now_km': nowKm,
        'next_service': nextService,
        'jenis_ken': jenisKen,
        'type_ken': typeKen,
        'driver': driver,
        'no_buntut': noBuntut,
      };

      print('Data yang akan dikirim untuk update: $data'); // Debugging

      final response = await _dio.put(
        '/service/$idMtc',
        data: data, // Kirim data sebagai JSON
      );

      if (response.statusCode == 200) {
        Get.back();
        SnackbarLoader.successSnackBar(
          title: 'Sukses',
          message: 'Service berkala diperbarui.',
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

  deleteService(String idMtc) async {
    isLoading.value = true;
    try {
      final response = await _dio.delete('/service/$idMtc');

      if (response.statusCode == 200) {
        await getData();
        SnackbarLoader.successSnackBar(
          title: 'Berhasil',
          message: response.data['message'] ?? 'Laporan berhasil dihapus',
        );
        Navigator.of(Get.overlayContext!).pop();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: response.data['message'] ?? 'Gagal menghapus laporan',
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

  logout() {
    localStorage.remove('username');
    localStorage.remove('type_user');
    localStorage.write('isLoggedIn', false);
    Get.offAllNamed(Routes.LOGIN);
  }
}
