import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:service/routes/app_pages.dart';

import '../../../utils/loadings/snackbar.dart';
import '../../service berkala/model/service_model.dart';

class HomeKepalaPoolController extends GetxController {
  final localStorage = GetStorage();
  RxBool isLoading = false.obs;
  RxList<ServiceModel> serviceModel = <ServiceModel>[].obs;

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
      final response = await _dio.get('/service-kpool');

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

  logout() {
    localStorage.remove('username');
    localStorage.remove('type_user');
    localStorage.write('isLoggedIn', false);
    Get.offAllNamed(Routes.LOGIN);
  }
}
