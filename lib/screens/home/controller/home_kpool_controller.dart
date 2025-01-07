import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:service/routes/app_pages.dart';

import '../../../utils/loadings/snackbar.dart';
import '../../service berkala/model/mtc_model.dart';

class HomeKepalaPoolController extends GetxController {
  final localStorage = GetStorage();
  RxBool isLoading = false.obs;
  RxString username = ''.obs;
  RxString typeUser = ''.obs;
  RxList<MtcModel> mtcModel = <MtcModel>[].obs;

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
    username.value = localStorage.read('username') ?? '';
    typeUser.value = localStorage.read('type_user') ?? '';
  }

  getData() async {
    isLoading.value = true;

    try {
      final response = await _dio.get('/service-kpool');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        mtcModel.value = data.map((e) => MtcModel.fromJson(e)).toList();
        print('ini response user : ${mtcModel.toList()}');
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

  // changeStatus({required String id}) async {
  //   isLoading.value = true;

  //   try {
  //     final data = {
  //       'id_mtc': id,
  //       'status': '1',
  //     };
  //     final response = await _dio.put('/change-status', data: data);

  //     if (response.statusCode == 200) {
  //       await getData();
  //       SnackbarLoader.successSnackBar(
  //         title: 'Sukses',
  //         message:
  //             response.data['message'] ?? 'Lampiran MTC berhasil di konfirmasi',
  //       );
  //     } else {
  //       SnackbarLoader.errorSnackBar(
  //         title: 'Error',
  //         message: response.data['message'] ?? 'Terjadi kesalahan',
  //       );
  //     }
  //   } catch (e) {
  //     SnackbarLoader.errorSnackBar(
  //       title: 'Error',
  //       message: 'Terjadi kesalahan: $e',
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  logout() {
    localStorage.remove('username');
    localStorage.remove('add');
    localStorage.remove('edit');
    localStorage.remove('delete');
    localStorage.remove('type_user');
    localStorage.write('isLoggedIn', false);
    Get.offAllNamed(Routes.LOGIN);
  }
}
