import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:service/screens/home/controller/home_staff_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widget/expandable_container.dart';
import '../../../utils/widget/pdf_preview.dart';
import '../../service berkala/model/mtc_model.dart';
import '../../service berkala/page/acc_staff_view.dart';
import '../../service berkala/page/edit_service_berkala.dart';
import '../../service berkala/source/mtc_source.dart';

class HomeStaffView extends GetView<HomeStaffController> {
  const HomeStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'DATA YANG HARUS DI ACC',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
          ),
          actions: [
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
                ExpandableContainer(
                  icon: Iconsax.user,
                  textTitle: 'Master Kategori Sevice',
                  content: Column(
                    children: [
                      ListTile(
                        onTap: () => Get.toNamed(Routes.MASTER_PART),
                        leading: const Icon(
                          Iconsax.record,
                          color: AppColors.black,
                        ),
                        title: Text(
                          'Kategori Service',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.black),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(Routes.DETAIL_KATEGORI),
                        leading: const Icon(
                          Iconsax.record,
                          color: AppColors.black,
                        ),
                        title: Text(
                          'Detail Kategori Service',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.black),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(Routes.MASTER_TYPE_ITEM),
                        leading: const Icon(
                          Iconsax.record,
                          color: AppColors.black,
                        ),
                        title: Text(
                          'Type Kategori',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                ExpandableContainer(
                    icon: Iconsax.support,
                    textTitle: 'Master Lainnya',
                    content: Column(
                      children: [
                        ListTile(
                          onTap: () => Get.toNamed(Routes.MASTER_KENDARAAN),
                          leading: const Icon(
                            Iconsax.record,
                            color: AppColors.black,
                          ),
                          title: Text(
                            'Master Jenis Kendaraan',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () => Get.toNamed(Routes.MASTER_KETERANGAN),
                          leading: const Icon(
                            Iconsax.record,
                            color: AppColors.black,
                          ),
                          title: Text(
                            'Master Keterangan',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () => Get.toNamed(Routes.MASTER_SATUAN),
                          leading: const Icon(
                            Iconsax.record,
                            color: AppColors.black,
                          ),
                          title: Text(
                            'Master Satuan',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColors.black),
                          ),
                        ),
                      ],
                    )),
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
                    if (model.status == '2') {
                      print(
                          'INI AKAN DI ACC OLEH STAFF DAN MERUBAH STATUS NYA MENJADI 3');
                      final result =
                          await Get.to(() => AccStaffView(idMtc: model.id));
                      if (result == true) {
                        controller.getData();
                      }
                    }
                    if (model.status == '3') {
                      // Generate dua jenis PDF
                      print('Start generating PDF with header...');
                      final startTime = DateTime.now();
                      final pdfBytesWithHeader =
                          await controller.generatePDF(model, withHeader: true);

                      final pdfBytesWithoutHeader = await controller
                          .generatePDF(model, withHeader: false);

                      final endTime = DateTime.now();
                      print(
                          'PDF generated in ${endTime.difference(startTime).inMilliseconds} ms');

                      // Navigasi ke layar preview PDF
                      if (pdfBytesWithHeader.isNotEmpty &&
                          pdfBytesWithoutHeader.isNotEmpty) {
                        Get.to(
                          () => PdfPreviewScreen(
                            pdfBytesWithHeader: pdfBytesWithHeader,
                            pdfBytesWithoutHeader: pdfBytesWithoutHeader,
                            fileName:
                                'Acc-Service-Berkala-${DateFormat('dd MMM yyyy').format(DateTime.now())}.pdf',
                          ),
                        );
                      }
                    }
                    // if (model.status == '0') {
                    //   final result = await Get.toNamed(Routes.SERVICE_BERKALA,
                    //       arguments: {'id_mtc': model.id});

                    //   if (result == true) {
                    //     controller.getData();
                    //   }
                    // } else if (model.status == '1') {
                    //   Get.to(() => InputDataReal(idMtc: model.id));
                    // } else if (model.status == '2') {
                    //   // Generate dua jenis PDF
                    //   print('Start generating PDF with header...');
                    //   final startTime = DateTime.now();
                    //   final pdfBytesWithHeader =
                    //       await controller.generatePDF(model, withHeader: true);

                    //   final pdfBytesWithoutHeader = await controller
                    //       .generatePDF(model, withHeader: false);

                    //   final endTime = DateTime.now();
                    //   print(
                    //       'PDF generated in ${endTime.difference(startTime).inMilliseconds} ms');

                    //   // Navigasi ke layar preview PDF
                    //   if (pdfBytesWithHeader.isNotEmpty &&
                    //       pdfBytesWithoutHeader.isNotEmpty) {
                    //     Get.to(
                    //       () => PdfPreviewScreen(
                    //         pdfBytesWithHeader: pdfBytesWithHeader,
                    //         pdfBytesWithoutHeader: pdfBytesWithoutHeader,
                    //         fileName:
                    //             'Acc-Service-Berkala-${DateFormat('dd MMM yyyy').format(DateTime.now())}.pdf',
                    //       ),
                    //     );
                    //   }
                    // }
                  },
                  onEdit: (MtcModel model) {
                    Get.to(() => EditServiceBerkalaAdmin(model: model),
                        transition: Transition.fadeIn);
                  },
                  onDelete: (MtcModel model) {
                    // CustomDialogs.deleteDialog(
                    //   context: context,
                    //   onConfirm: () => controller.deleteService(model.id),
                    // );
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
                        columnName: 'Tgl Dibuat',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Tgl Dibuat',
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
                        columnName: 'Mekanik/User Input',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Mekanik/User Input',
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
                        columnName: 'Merk Mobil',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Merk Mobil',
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
