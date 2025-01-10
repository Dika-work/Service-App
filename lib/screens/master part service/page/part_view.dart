import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/utils/widget/dialogs.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../master type item/controller/master_type_item_controller.dart';
import '../../master type item/model/master_type_item_model.dart';
import '../controller/part_controller.dart';
import '../model/part_model.dart';
import '../source/part_source.dart';
import 'edit_part.dart';

class PartMaster extends GetView<PartController> {
  const PartMaster({super.key});

  @override
  Widget build(BuildContext context) {
    final masterTypeItemController = Get.put(MasterTypeItemController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Master Kategori Service',
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
                    controller.namaItemC.clear();
                    Navigator.of(Get.overlayContext!).pop();
                  },
                  onConfirm: () {
                    controller.createPart(
                        masterTypeItemController.selectedTypeItem.value);
                  },
                  titleWidget: Center(
                    child: Text(
                      'Tambah Kategori',
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
                              if (masterTypeItemController.isLoading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (masterTypeItemController
                                  .masterTypeItemModel.isEmpty) {
                                return const Text('No type items available');
                              }

                              return DropdownButton<String>(
                                value: masterTypeItemController
                                        .selectedTypeItem.value.isEmpty
                                    ? null
                                    : masterTypeItemController
                                        .selectedTypeItem.value,
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
                                  masterTypeItemController
                                      .selectedTypeItem.value = newValue!;
                                  print(
                                      'Selected ID: ${masterTypeItemController.selectedTypeItem.value}');
                                },
                                items: masterTypeItemController
                                    .masterTypeItemModel
                                    .map<DropdownMenuItem<String>>(
                                        (MasterTypeItemModel item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id, // Simpan ID di sini
                                    child: Text(
                                      item.typeItem, // Tampilkan type_item
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

                          // TextFormField(
                          //   controller: controller.typeC,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return '* Type part tidak boleh kosong';
                          //     }
                          //     return null;
                          //   },
                          //   keyboardType: TextInputType.text,
                          //   decoration: InputDecoration(
                          //     label: Text('Type Part',
                          //         style:
                          //             Theme.of(context).textTheme.labelMedium),
                          //   ),
                          // ),
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
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.only(top: 10.0),
        color: Colors.white,
        child: Obx(() {
          if (controller.isLoading.value && controller.partModel.isEmpty) {
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
            final dataSource = PartSource(
              model: controller.partModel,
              onEdit: (PartModel model) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return EditPartMaster(model: model);
                  },
                );
              },
              // onDelete: (PartModel model) {
              //   CustomDialogs.deleteDialog(
              //     context: context,
              //     onConfirm: () => controller.deletePart(model.id),
              //   );
              // }
            );

            return RefreshIndicator(
              onRefresh: () async {
                await controller.getData();
              },
              child: SfDataGrid(
                source: dataSource,
                frozenColumnsCount: 2,
                rowHeight: 65,
                columnWidthMode: ColumnWidthMode.fill,
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
                  if (controller.partModel.isNotEmpty)
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
                  // if (controller.partModel.isNotEmpty)
                  //   GridColumn(
                  //       width: 120,
                  //       columnName: 'Hapus',
                  //       label: Container(
                  //           alignment: Alignment.center,
                  //           decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.grey),
                  //             color: Colors.lightBlue.shade100,
                  //           ),
                  //           child: Text(
                  //             'Hapus',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyMedium
                  //                 ?.copyWith(fontWeight: FontWeight.bold),
                  //           ))),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
