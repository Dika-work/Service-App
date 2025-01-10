import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/utils/widget/dialogs.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../controller/master_kendaraan_controller.dart';
import '../source/master_kendaraan_source.dart';

class MasterKendaraanView extends GetView<MasterKendaraanController> {
  const MasterKendaraanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Master Jenis Kendaraan',
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
                  onConfirm: () => controller.createJenisKendaraan(),
                  confirmText: 'Tambah',
                  titleWidget: Center(
                    child: Text(
                      'Tambah Jenis Kendaraan',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  contentWidget: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: controller.jenisKenC,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              label: Text(
                            'Jenis Kendaraan',
                            style: Theme.of(context).textTheme.labelMedium,
                          )),
                        ),
                        const SizedBox(height: CustomSize.sm),
                        TextFormField(
                          controller: controller.merkC,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              label: Text(
                            'Merk',
                            style: Theme.of(context).textTheme.labelMedium,
                          )),
                        ),
                        const SizedBox(height: CustomSize.sm),
                        TextFormField(
                          controller: controller.typeC,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              label: Text(
                            'Type',
                            style: Theme.of(context).textTheme.labelMedium,
                          )),
                        ),
                      ],
                    ),
                  ));
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
          ),
        ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.only(top: 10.0),
        color: Colors.white,
        child: Obx(() {
          if (controller.isLoading.value &&
              controller.masterKendaraanModel.isEmpty) {
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
            final dataSource = MasterKendaraanSource(
              model: controller.masterKendaraanModel,
            );

            return RefreshIndicator(
              onRefresh: () async {},
              child: SfDataGrid(
                  source: dataSource,
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
                        columnName: 'Jenis Kendaraan',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Jenis Kendaraan',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Merk',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Merk',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Type',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Type',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                  ]),
            );
          }
        }),
      ),
    );
  }
}
