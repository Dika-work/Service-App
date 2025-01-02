import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widget/dialogs.dart';
import '../controller/service_berkala_controller.dart';
import '../source/detail_service_berkala.dart';

class MasterDetailServiceBerkala extends GetView<ServiceBerkalaController> {
  const MasterDetailServiceBerkala({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Detail Kategori Service',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              CustomDialogs.defaultDialog(
                  context: context,
                  confirmText: 'Tambah',
                  cancelText: 'Kembali',
                  onCancel: () {
                    Navigator.of(Get.overlayContext!).pop();
                  },
                  onConfirm: () => controller.createDetailService(),
                  titleWidget: Center(
                    child: Text(
                      'Tambah Part',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                  contentWidget: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.namaItemC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Nama item tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('Nama Item',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                          const SizedBox(height: CustomSize.sm),
                          TextFormField(
                            controller: controller.kmTargetC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('KM Target',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                          const SizedBox(height: CustomSize.sm),
                          TextFormField(
                            controller: controller.bulanTargetC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('Target (BULAN)',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                          const SizedBox(height: CustomSize.sm),
                          TextFormField(
                            controller: controller.tahunTargetC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('Target (TAHUN)',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                          const SizedBox(height: CustomSize.sm),
                          TextFormField(
                            controller: controller.kondisiFisikC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('Fisik (CIRI KHUSUS)',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                          const SizedBox(height: CustomSize.sm),
                          TextFormField(
                            controller: controller.qtyC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('QTY DI KENDARAAN',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ],
                      )));
            },
            child: Container(
              padding: const EdgeInsets.all(CustomSize.xs),
              margin: const EdgeInsets.fromLTRB(
                  0, CustomSize.sm, CustomSize.sm, CustomSize.sm),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomSize.borderRadiusSm),
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
          )
        ],
      ),
      body: SafeArea(child: Obx(() {
        if (controller.isLoading.value &&
            controller.detailServiceModel.isEmpty) {
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
          final dataSource =
              DetailServiceBerkalaSource(model: controller.detailServiceModel);

          return RefreshIndicator(
              onRefresh: () async {},
              child: SfDataGrid(
                source: dataSource,
                rowHeight: 65,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columnWidthMode: ColumnWidthMode.auto,
                stackedHeaderRows: [
                  StackedHeaderRow(cells: [
                    StackedHeaderCell(
                      columnNames: [
                        'KM',
                        'TARGET\n(BULAN)',
                        'TARGET\n(TAHUN)',
                        'FISIK\n(CIRI KHUSUS)',
                        'QTY\nDI KENDARAAN'
                      ],
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.lightBlue.shade100,
                        ),
                        child: const Text(
                          'STANDART',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
                ],
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
                      columnName: 'Deskripsi\nPengecekan',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'Deskripsi\nPengecekan',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                  GridColumn(
                      columnName: 'KM',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'KM',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                  GridColumn(
                      columnName: 'TARGET\n(BULAN)',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'TARGET\n(BULAN)',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                  GridColumn(
                      columnName: 'TARGET\n(TAHUN)',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'TARGET\n(TAHUN)',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                  GridColumn(
                      columnName: 'FISIK\n(CIRI KHUSUS)',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'FISIK\n(CIRI KHUSUS)',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                  GridColumn(
                      columnName: 'QTY\nDI KENDARAAN',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'QTY\nDI KENDARAAN',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                ],
              ));
        }
      })),
    );
  }
}
