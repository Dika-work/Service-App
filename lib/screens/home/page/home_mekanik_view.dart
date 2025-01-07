import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:service/screens/home/controller/home_mekanik_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widget/dialogs.dart';
import '../../service berkala/model/mtc_model.dart';
import '../../service berkala/page/edit_service_berkala.dart';
import '../../service berkala/source/mtc_source.dart';

class HomeMekanikView extends GetView<HomeMekanikController> {
  const HomeMekanikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryExtraSoft,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Service Berkala',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
          ),
          actions: [
            if (controller.canAdd == '1')
              GestureDetector(
                onTap: () async {
                  final result = await Get.toNamed(Routes.ADD_MTC);

                  if (result == true) {
                    controller.getData();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(CustomSize.xs),
                  margin: const EdgeInsets.fromLTRB(
                      0, CustomSize.sm, 0, CustomSize.sm),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(CustomSize.borderRadiusSm),
                    color: AppColors.buttonPrimary,
                  ),
                  child: Text(
                    'TAMBAH',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Iconsax.firstline),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: CustomSize.imageCarouselHeight,
                      padding: const EdgeInsets.only(top: CustomSize.lg),
                      decoration: const BoxDecoration(
                        color: AppColors.light,
                        image: DecorationImage(
                            image: AssetImage('assets/images/ship.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned.fill(
                        child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.username.value.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: AppColors.white),
                                  ),
                                  Text(
                                    controller.typeUser.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 6,
                              left: 5,
                              right: 5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[500]!,
                                    highlightColor: Colors.white,
                                    child: Text(
                                      'Langgeng Pranamas Sentosa',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () =>
                                            Scaffold.of(context).closeDrawer(),
                                        child: const Icon(
                                          Iconsax.back_square,
                                          size: CustomSize.iconMd,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.ALL_MTC),
                  leading: const Icon(
                    Iconsax.record,
                    color: AppColors.black,
                  ),
                  title: Text(
                    'Seluruh MTC',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.black),
                  ),
                ),
                ListTile(
                  onTap: () => controller.logout(),
                  leading: const Icon(
                    Iconsax.logout,
                    color: AppColors.black,
                  ),
                  title: Text(
                    'Keluar',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          margin: const EdgeInsets.only(top: 10.0),
          color: Colors.white,
          child: Obx(() {
            if (controller.isLoading.value && controller.mtcModel.isEmpty) {
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(CustomSize.sm),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              );
            } else {
              final dataSource = MtcSource(
                  model: controller.mtcModel,
                  onServis: (MtcModel model) async {
                    if (model.status == '0') {
                      final result = await Get.toNamed(Routes.SERVICE_BERKALA,
                          arguments: {'id_mtc': model.id});

                      if (result == true) {
                        controller.getData();
                      }
                    } else if (model.status == '1') {
                      print('Ini bakalan navigate ke page lain status 1');
                    }
                  },
                  onEdit: (MtcModel model) {
                    Get.to(() => EditServiceBerkalaMekanik(model: model),
                        transition: Transition.fadeIn);
                  },
                  onDelete: (MtcModel model) {
                    CustomDialogs.deleteDialog(
                      context: context,
                      onConfirm: () => controller.deleteService(model.id),
                    );
                  });

              return RefreshIndicator(
                onRefresh: () async {
                  await controller.getData();
                },
                child: SfDataGrid(
                  source: dataSource,
                  frozenColumnsCount: 2,
                  rowHeight: 65,
                  columnWidthMode: ColumnWidthMode.auto,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columns: [
                    GridColumn(
                        width: 50,
                        columnName: 'No',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'No',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Mekanik',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Mekanik',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'K.Pool',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'K.Pool',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'No Polisi',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'No Polisi',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'KM Terakhir Servis',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'KM Terakhir Servis',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'KM Saat Ini',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'KM Saat Ini',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'KM Servis Selanjutnya',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'KM Servis Selanjutnya',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Jenis Mobil',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Jenis Mobil',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Type Mobil',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Type Mobil',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Driver',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Driver',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'No Buntut',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'No Buntut',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Status',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Status',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    if (controller.mtcModel.isNotEmpty &&
                        controller.canAdd == '1')
                      GridColumn(
                          width: 120,
                          columnName: 'Service',
                          label: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.lightBlue.shade100,
                              ),
                              child: Text(
                                'Service',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ))),
                    if (controller.mtcModel.isNotEmpty &&
                        controller.canEdit == '1')
                      GridColumn(
                          width: 120,
                          columnName: 'Edit',
                          label: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.lightBlue.shade100,
                              ),
                              child: Text(
                                'Edit',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ))),
                    if (controller.mtcModel.isNotEmpty &&
                        controller.canDelete == '1')
                      GridColumn(
                          width: 120,
                          columnName: 'Hapus',
                          label: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.lightBlue.shade100,
                              ),
                              child: Text(
                                'Hapus',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ))),
                  ],
                ),
              );
            }
          }),
        ));
  }
}
