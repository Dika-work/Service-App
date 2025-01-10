import 'package:get/get.dart';

import '../screens/master kendaraan/controller/master_kendaraan_controller.dart';
import '../screens/master keterangan/controller/master_keterangan_controller.dart';
import '../screens/master type item/controller/master_type_item_controller.dart';
import '../screens/satuan/controller/master_satuan_controller.dart';
import '../screens/group user/controller/group_user_controller.dart';
import '../screens/home/controller/home_kpool_controller.dart';
import '../screens/home/controller/home_mekanik_controller.dart';
import '../screens/home/controller/home_staff_controller.dart';
import '../screens/home/controller/home_super_admin_controller.dart';
import '../screens/login/controller/login_controller.dart';
import '../screens/master part service/controller/part_controller.dart';
import '../screens/master user/controller/user_controller.dart';
import '../screens/service berkala/controller/all_mtc_controller.dart';
import '../screens/service berkala/controller/mtc_controller.dart';
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

class MtcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MtcController>(() => MtcController());
  }
}

class AllMtcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllMtcController>(() => AllMtcController());
  }
}

class SatuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterSatuanController>(() => MasterSatuanController());
  }
}

class MasterKendaraanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterKendaraanController>(() => MasterKendaraanController());
  }
}

class MasterTypeItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterTypeItemController>(() => MasterTypeItemController());
  }
}

class MasterKeteranganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterKeteranganController>(() => MasterKeteranganController());
  }
}
