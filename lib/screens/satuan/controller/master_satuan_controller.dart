import 'package:get/get.dart';
import 'package:dio/dio.dart' as diomultipart;

import '../../../utils/loadings/snackbar.dart';
import '../model/satuan_model.dart';

class MasterSatuanController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SatuanModel> satuanModel = <SatuanModel>[].obs;

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://192.168.1.4:8080',
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
      final response = await _dio.get(
        '/master-satuan',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        satuanModel.value = data.map((e) => SatuanModel.fromJson(e)).toList();
      } else {
        SnackbarLoader.errorSnackBar(
          title: 'Gagal',
          message: 'Gagal mengambil data mekanik.',
        );
      }
    } on diomultipart.DioException catch (e) {
      SnackbarLoader.warningSnackBar(
        title: 'Error',
        message: e.response?.data['message'] ?? 'Terjadi kesalahan',
      );
      print(
          'Error getData: ${e.response?.data['message'] ?? 'Terjadi kesalahan'}');
    } finally {
      isLoading.value = false;
    }
  }
}
