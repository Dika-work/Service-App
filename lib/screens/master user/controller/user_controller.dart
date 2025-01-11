import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:service/utils/loadings/snackbar.dart';

import '../model/user_model.dart';

class MasterUserController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obscureText = true.obs;
  RxBool confirmObscureText = true.obs;
  final formKey = GlobalKey<FormState>();

  RxList<UserModel> userModel = <UserModel>[].obs;
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController confirmPasswordC = TextEditingController();
  // RxString selectedTypeUser = 'Mekanik'.obs;

  // final List<String> typeUserOptions = [
  //   'Super Admin',
  //   'Kpool',
  //   'Mekanik',
  //   'Staff',
  // ];

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
    getAllUser();
  }

  getAllUser() async {
    isLoading.value = true;

    try {
      final response = await _dio.get('/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        userModel.value = data.map((e) => UserModel.fromJson(e)).toList();
        print('ini response user : ${userModel.toList()}');
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

  createNewUser(String groupIdUser, String selectedGroupId) async {
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    if (selectedGroupId == '') {
      isLoading.value = false;
      SnackbarLoader.errorSnackBar(
          title: 'Oops', message: 'Kategori user harus di isi');
      return;
    }

    if (passwordC.text != confirmPasswordC.text) {
      isLoading.value = false;
      SnackbarLoader.errorSnackBar(
          title: 'Oops', message: 'Password dan Confirm Password tidak sama');
      return;
    }

    try {
      diomultipart.FormData formData = diomultipart.FormData.fromMap({
        'username': usernameC.text.trim(),
        'group_id': groupIdUser,
        'password': passwordC.text.trim(),
      });

      final response = await _dio.post('/users', data: formData);

      if (response.statusCode == 201) {
        SnackbarLoader.successSnackBar(
          title: 'Success',
          message: response.data['message'] ?? 'User berhasil ditambahkan',
        );

        usernameC.clear();
        passwordC.clear();
        confirmPasswordC.clear();

        await getAllUser();
        Navigator.of(Get.overlayContext!).pop();
      } else {
        SnackbarLoader.errorSnackBar(
            title: 'Oops👻',
            message: response.data['message'] ?? 'Gagal menambahkan pengguna');
      }
    } on diomultipart.DioException catch (e) {
      if (e.response?.statusCode == 429) {
        SnackbarLoader.warningSnackBar(
            title: 'Limit Exceeded',
            message: 'Terlalu banyak permintaan. Coba lagi nanti');
      } else {
        SnackbarLoader.warningSnackBar(
            title: 'Oops',
            message: e.response?.data['message'] ?? 'Terjadi kesalahan');
      }
    } finally {
      isLoading.value = false;
    }
  }

  updateUser(
    String id,
    String username,
    String typeUser,
    // String password,
  ) async {
    isLoading.value = true;
    try {
      final data = {
        'username': username,
        'group_id': typeUser,
        // 'password': password,
      };

      // Kirim data ke API
      final response = await _dio.put(
        '/users/$id',
        data: data,
      );

      if (response.statusCode == 200) {
        SnackbarLoader.successSnackBar(
          title: 'Berhasil',
          message: response.data['message'] ?? 'Data user berhasil diperbarui',
        );

        // Bersihkan input form
        passwordC.clear();

        // Refresh daftar user
        await getAllUser();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: response.data['message'] ?? 'Gagal memperbarui data user',
        );
      }
    } on diomultipart.DioException catch (e) {
      SnackbarLoader.errorSnackBar(
        title: 'Kesalahan',
        message: e.response?.data['message'] ?? 'Terjadi kesalahan pada server',
      );
      print('Error updateUser: ${e.response?.data['message']}');
    } finally {
      isLoading.value = false;
    }
  }

  deleteUser(String username) async {
    isLoading.value = true;
    try {
      final response =
          await _dio.delete('/delete-user', data: {'username': username});

      if (response.statusCode == 200) {
        await getAllUser();
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
}
