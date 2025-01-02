import 'package:get/get.dart';
import 'package:service/screens/group%20user/controller/group_user_controller.dart';
import 'package:service/screens/home/controller/home_kpool_controller.dart';
import 'package:service/screens/home/controller/home_mekanik_controller.dart';
import 'package:service/screens/home/controller/home_staff_controller.dart';
import 'package:service/screens/home/controller/home_super_admin_controller.dart';
import 'package:service/screens/login/controller/login_controller.dart';
import 'package:service/screens/master%20user/controller/user_controller.dart';

import '../screens/master part service/controller/part_controller.dart';
import '../screens/service berkala/controller/service_berkala_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class HomeSuperAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSuperAdminController>(() => HomeSuperAdminController());
  }
}

class HomeKepalaPoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeKepalaPoolController>(() => HomeKepalaPoolController());
  }
}

class HomeMekanikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeMekanikController>(() => HomeMekanikController());
  }
}

class HomeStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeStaffController>(() => HomeStaffController());
  }
}

class MasterUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterUserController>(() => MasterUserController());
  }
}

class GroupUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupUserController>(() => GroupUserController());
  }
}

class ServiceBerkalaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceBerkalaController>(() => ServiceBerkalaController());
  }
}

class MasterPartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartController>(() => PartController());
  }
}
