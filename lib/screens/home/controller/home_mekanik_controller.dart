import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:service/routes/app_pages.dart';

class HomeMekanikController extends GetxController {
  final localStorage = GetStorage();

  logout() {
    localStorage.remove('username');
    localStorage.remove('type_user');
    localStorage.write('isLoggedIn', false);
    Get.offAllNamed(Routes.LOGIN);
  }
}
