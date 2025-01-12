import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:service/routes/app_pages.dart';
import 'package:service/utils/loadings/snackbar.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obscureText = true.obs;
  final rememberMe = false.obs;
  final formKey = GlobalKey<FormState>();
  final localStorage = GetStorage();

  TextEditingController usernameC = TextEditingController();
  TextEditingController passC = TextEditingController();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.4:8080', // Ganti dengan URL backend Anda
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  @override
  void onInit() {
    usernameC.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    passC.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  loginEmailandPassword() async {
    isLoading.value = true;
    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    if (rememberMe.value) {
      // Simpan username dan password jika opsi "Ingat Saya" aktif
      localStorage.write('REMEMBER_ME_EMAIL', usernameC.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', passC.text.trim());
    }

    try {
      final response = await _dio.post(
        '/login',
        data: {
          'username': usernameC.text,
          'password': passC.text,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];

        localStorage.write('username', data['username']);
        localStorage.write('add', data['add']);
        localStorage.write('edit', data['edit']);
        localStorage.write('delete', data['delete']);
        localStorage.write('type_user', data['type_user']);

        await localStorage.write('isLoggedIn', true);

        SnackbarLoader.successSnackBar(
            title: 'Success',
            message: response.data['message'] ?? 'Login berhasil');

        // Navigasi berdasarkan type_user
        if (data['type_user'] == 'admin') {
          Get.offAllNamed(Routes.HOME_SUPER_ADMIN);
        } else if (data['type_user'] == 'kpool') {
          Get.offAllNamed(Routes.HOME_KPOOL);
        } else if (data['type_user'] == 'mekanik' ||
            data['type_user'] == 'pic') {
          Get.offAllNamed(Routes.HOME_MEKANIK);
        } else if (data['type_user'] == 'staff') {
          Get.offAllNamed(Routes.HOME_STAFF);
        } else {
          SnackbarLoader.errorSnackBar(
              title: 'Oops',
              message: response.data['message'] ?? 'Tipe pengguna tidak valid');
        }
      } else {
        print('Terjadi kesalahan saat ingin login ${response.data['message']}');
        SnackbarLoader.errorSnackBar(
            title: 'Oops👻',
            message: response.data['message'] ?? 'Terjadi kesalahan');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        SnackbarLoader.warningSnackBar(
            title: 'Limit Exceeded',
            message: 'Terlalu banyak permintaan. Coba lagi nanti');
      } else {
        SnackbarLoader.warningSnackBar(
            title: 'Oops',
            message: e.response?.data['message'] ?? 'Terjadi kesalahan');
        print('ini error saat mau login $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
