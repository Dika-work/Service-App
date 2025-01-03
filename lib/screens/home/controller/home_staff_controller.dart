import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:service/routes/app_pages.dart';

class HomeStaffController extends GetxController {
  final localStorage = GetStorage();
  RxString username = ''.obs;
  RxString typeUser = ''.obs;

  @override
  void onInit() {
    super.onInit();
    username.value = localStorage.read('username') ?? '';
    typeUser.value = localStorage.read('type_user') ?? '';
  }

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
