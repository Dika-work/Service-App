import 'package:get/get.dart';
import 'package:service/routes/bindings.dart';
import 'package:service/screens/home/page/home_kepala_pool_view.dart';
import 'package:service/screens/home/page/home_mekanik_view.dart';
import 'package:service/screens/home/page/home_staff_view.dart';
import 'package:service/screens/home/page/home_super_admin_view.dart';
import 'package:service/screens/login/page/login_view.dart';

import '../screens/group user/page/group_user_view.dart';
import '../screens/master part service/page/part_view.dart';
import '../screens/master user/page/user_view.dart';
import '../screens/service berkala/page/add_service_berkala.dart';
import '../screens/service berkala/page/master_detail_service_berkala.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const HOME_SUPER_ADMIN = Routes.HOME_SUPER_ADMIN;
  static const HOME_KPOOL = Routes.HOME_KPOOL;
  static const HOME_MEKANIK = Routes.HOME_MEKANIK;
  static const HOME_STAFF = Routes.HOME_STAFF;
  static const MASTER_USER = Routes.MASTER_USER;
  static const SERVICE_BERKALA = Routes.SERVICE_BERKALA;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SUPER_ADMIN,
      page: () => const HomeSuperAdmin(),
      binding: HomeSuperAdminBinding(),
    ),
    GetPage(
      name: _Paths.HOME_KPOOL,
      page: () => const HomeKepalaPoolView(),
      binding: HomeKepalaPoolBinding(),
    ),
    GetPage(
      name: _Paths.HOME_MEKANIK,
      page: () => const HomeMekanikView(),
      binding: HomeMekanikBinding(),
    ),
    GetPage(
      name: _Paths.HOME_STAFF,
      page: () => const HomeStaffView(),
      binding: HomeStaffBinding(),
    ),
    GetPage(
      name: _Paths.MASTER_USER,
      page: () => const MasterUser(),
      binding: MasterUserBinding(),
    ),
    GetPage(
      name: _Paths.GROUP_USER,
      page: () => const GroupUserView(),
      binding: GroupUserBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_BERKALA,
      page: () => const AddServiceBerkala(),
      transition: Transition.rightToLeft,
      binding: ServiceBerkalaBinding(),
    ),
    GetPage(
      name: _Paths.MASTER_PART,
      page: () => const PartMaster(),
      binding: MasterPartBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KATEGORI,
      page: () => const MasterDetailServiceBerkala(),
      binding: ServiceBerkalaBinding(),
    ),
  ];
}
