import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widget/dialogs.dart';
import '../../master part service/controller/part_controller.dart';
import '../../master part service/model/part_model.dart';
import '../controller/master_keterangan_controller.dart';
import '../source/master_leterangan_source.dart';

class MasterKeteranganView extends GetView<MasterKeteranganController> {
  const MasterKeteranganView({super.key});

  @override
  Widget build(BuildContext context) {
    final partController = Get.put(PartController());
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
                  onConfirm: () => controller.createMasterKeterangan(
                      partController.selectedNameItem.value),
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
                        Container(
                          padding: const EdgeInsets.only(
                              left: CustomSize.sm, right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                CustomSize.inputFieldRadius),
                            border: Border.all(
                                width: 1, color: AppColors.borderPrimary),
                          ),
                          child: Obx(() {
                            if (partController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (partController.partModel.isEmpty) {
                              return const Text('No type items available');
                            }

                            return DropdownButton<String>(
                              value:
                                  partController.selectedNameItem.value.isEmpty
                                      ? null
                                      : partController.selectedNameItem.value,
                              underline: const SizedBox.shrink(),
                              hint: Text(
                                'Select Type Item',
                                style: const TextStyle().copyWith(
                                  fontSize: CustomSize.fontSizeSm,
                                  color: AppColors.textPrimary,
                                  fontFamily: 'Urbanist',
                                ),
                              ),
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                partController.selectedNameItem.value =
                                    newValue!;
                                print(
                                    'Selected selectedNameItem: ${partController.selectedNameItem.value}');
                              },
                              items: partController.partModel
                                  .map<DropdownMenuItem<String>>(
                                      (PartModel item) {
                                return DropdownMenuItem<String>(
                                  value: item.namaItem,
                                  child: Text(
                                    item.namaItem, // Tampilkan type_item
                                    style: const TextStyle().copyWith(
                                      fontSize: CustomSize.fontSizeSm,
                                      color: AppColors.textPrimary,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ),
                        TextFormField(
                          controller: controller.keteranganC,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              label: Text(
                            'Jenis Kendaraan',
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
              controller.keteranganModel.isEmpty) {
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
            final dataSource = MasterLeteranganSource(
              model: controller.keteranganModel,
            );

            return RefreshIndicator(
              onRefresh: () async {},
              child: SfDataGrid(
                  source: dataSource,
                  columnWidthMode: controller.keteranganModel.isEmpty
                      ? ColumnWidthMode.fill
                      : ColumnWidthMode.auto,
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
                        columnName: 'Nama Item',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Nama Item',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Keterangan',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Keterangan',
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
