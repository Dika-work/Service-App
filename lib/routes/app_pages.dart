import 'package:get/get.dart';
import 'package:service/routes/bindings.dart';
import 'package:service/screens/home/page/home_kepala_pool_view.dart';
import 'package:service/screens/home/page/home_mekanik_view.dart';
import 'package:service/screens/home/page/home_staff_view.dart';
import 'package:service/screens/home/page/home_super_admin_view.dart';
import 'package:service/screens/login/page/login_view.dart';

import '../screens/master kendaraan/pages/master_kendaraan_view.dart';
import '../screens/master keterangan/pages/master_keterangan_view.dart';
import '../screens/master type item/page/master_type_item.dart';
import '../screens/satuan/pages/satuan_view.dart';
import '../screens/group user/page/group_user_view.dart';
import '../screens/master part service/page/part_view.dart';
import '../screens/master user/page/user_view.dart';
import '../screens/service berkala/page/add_mtc.dart';
import '../screens/service berkala/page/all_mtc.dart';
import '../screens/service berkala/page/transaksi_service_berkala.dart';
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
  static const ADD_MTC = Routes.ADD_MTC;
  static const ALL_MTC = Routes.ALL_MTC;
  static const MASTER_SATUAN = Routes.MASTER_SATUAN;
  static const MASTER_KENDARAAN = Routes.MASTER_KENDARAAN;
  static const MASTER_TYPE_ITEM = Routes.MASTER_TYPE_ITEM;
  static const MASTER_KETERANGAN = Routes.MASTER_KETERANGAN;

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
      page: () => const TransaksiServiceBerkala(),
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
    GetPage(
      name: _Paths.ADD_MTC,
      page: () => const AddMtcView(),
      binding: MtcBinding(),
    ),
    GetPage(
      name: _Paths.ALL_MTC,
      page: () => const AllMtcView(),
      binding: AllMtcBinding(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: _Paths.MASTER_SATUAN,
      page: () => const MasterSatuan(),
      binding: SatuanBinding(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: _Paths.MASTER_KENDARAAN,
      page: () => const MasterKendaraanView(),
      binding: MasterKendaraanBinding(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: _Paths.MASTER_TYPE_ITEM,
      page: () => const MasterTypeItemView(),
      binding: MasterTypeItemBinding(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: _Paths.MASTER_KETERANGAN,
      page: () => const MasterKeteranganView(),
      binding: MasterKeteranganBinding(),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
