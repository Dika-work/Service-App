import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;

import '../../../utils/loadings/snackbar.dart';
import '../model/group_user_model.dart';

class GroupUserController extends GetxController {
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  RxList<GroupUserModel> groupUserModel = <GroupUserModel>[].obs;

  RxnInt addOpsion = RxnInt();
  RxnInt editOpsion = RxnInt();
  RxnInt deleteOpsion = RxnInt();

  TextEditingController typeUserC = TextEditingController();

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
    getGroupUser();
  }

  getGroupUser() async {
    isLoading.value = true;

    try {
      final response = await _dio.get('/usergroups');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        groupUserModel.value =
            data.map((e) => GroupUserModel.fromJson(e)).toList();
        print('ini response user : ${groupUserModel.toList()}');
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

  // createGroupUser() async {
  //   isLoading.value = true;

  //   if (!formKey.currentState!.validate()) {
  //     isLoading.value = false;
  //     return;
  //   }

  //   try {
  //     diomultipart.FormData formData = diomultipart.FormData.fromMap({
  //       'type_user': typeUserC.text,
  //       'can_add': addOpsion.value,
  //       'can_edit': editOpsion.value,
  //       'can_delete': deleteOpsion.value
  //     });

  //     final response = await _dio.post(
  //       '/usergroups',
  //       data: formData,
  //     );

  //     if (response.statusCode == 201) {
  //       Navigator.of(Get.overlayContext!).pop();
  //       SnackbarLoader.successSnackBar(
  //         title: 'Berhasil',
  //         message: 'Group user berhasil ditambahkan.',
  //       );
  //     } else {
  //       SnackbarLoader.errorSnackBar(
  //         title: 'Gagal',
  //         message: response.data['message'] ?? 'Terjadi kesalahan.',
  //       );
  //     }
  //   } catch (e) {
  //     SnackbarLoader.errorSnackBar(
  //       title: 'Oops',
  //       message: 'Terjadi kesalahan: $e',
  //     );
  //     print('err create group user: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  deleteGroupUser(String id) async {
    isLoading.value = true;
    try {
      final response = await _dio.delete('/usergroups/$id');

      if (response.statusCode == 200) {
        await getGroupUser();
        SnackbarLoader.successSnackBar(
          title: 'Berhasil',
          message: response.data['message'] ?? 'Group user berhasil dihapus',
        );
        Navigator.of(Get.overlayContext!).pop();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: response.data['message'] ??
              'Gagal menghapus group user yang dipilih',
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
}
