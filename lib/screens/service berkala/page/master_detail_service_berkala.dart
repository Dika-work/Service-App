import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widget/dialogs.dart';
import '../../master part service/controller/part_controller.dart';
import '../../master part service/model/part_model.dart';
import '../controller/service_berkala_controller.dart';
import '../model/detail_service_model.dart';
import '../source/detail_service_berkala_source.dart';
import 'edit_detail_service_berkala.dart';

class MasterDetailServiceBerkala extends GetView<ServiceBerkalaController> {
  const MasterDetailServiceBerkala({super.key});

  @override
  Widget build(BuildContext context) {
    final PartController masterKategoriController = Get.put(PartController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Master Detail Kategori Service',
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
                    controller.kmTargetC.clear();
                    controller.bulanTargetC.clear();
                    controller.tahunTargetC.clear();
                    controller.kondisiFisikC.clear();
                    controller.qtyC.clear();
                    masterKategoriController.selectedKategoriName.value = '';
                    Navigator.of(Get.overlayContext!).pop();
                  },
                  onConfirm: () async {
                    await controller.createDetailService(
                        masterKategoriController.selectedKategoriName.value,
                        masterKategoriController.selectedKategoriName.value);

                    masterKategoriController.selectedKategoriName.value = '';
                  },
                  titleWidget: Center(
                    child: Text(
                      'Tambah Detail Kategori',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.black),
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
                              // Menampilkan indikator loading jika data sedang dimuat
                              if (masterKategoriController.isLoading.value) {
                                return const CircularProgressIndicator();
                              }

                              // Menampilkan pesan jika tidak ada data
                              if (masterKategoriController.partModel.isEmpty) {
                                return const Text('No group users available');
                              }

                              return DropdownButton<String>(
                                value: masterKategoriController
                                        .selectedKategoriName.value.isEmpty
                                    ? null
                                    : masterKategoriController
                                        .selectedKategoriName.value,
                                underline: const SizedBox.shrink(),
                                hint: Text(
                                  'Nama Item',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  masterKategoriController
                                      .selectedKategoriName.value = newValue!;
                                  print(
                                      'Selected group_id: ${masterKategoriController.selectedKategoriName.value}'); // Print group_id
                                },
                                items: masterKategoriController.partModel
                                    .map<DropdownMenuItem<String>>(
                                        (PartModel kategoriModel) {
                                  return DropdownMenuItem<String>(
                                    value: kategoriModel.namaItem,
                                    child: Text(
                                      kategoriModel.namaItem.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ), // Asumsikan partModel memiliki properti 'name'
                                  );
                                }).toList(),
                              );
                            }),
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
          final dataSource = DetailServiceBerkalaSource(
              model: controller.detailServiceModel,
              onEdit: (DetailServiceModel model) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return EditDetailServiceBerkala(model: model);
                    });
              },
              onDelete: (DetailServiceModel model) {
                CustomDialogs.deleteDialog(
                    context: context,
                    confirmText: 'Hapus',
                    onConfirm: () {
                      controller.deleteDetailService(model.id);
                    });
              });

          List<GridColumn> columns = [
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
            if (controller.detailServiceModel.isNotEmpty)
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
                  ),
                ),
              ),
            if (controller.detailServiceModel.isNotEmpty)
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
                  ),
                ),
              ),
          ];

          print('Jumlah kolum : ${columns.length}');
          return RefreshIndicator(
              onRefresh: () async {
                await controller.getData();
              },
              child: SfDataGrid(
                source: dataSource,
                rowHeight: 65,
                frozenColumnsCount: 1,
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
                columns: columns,
              ));
        }
      })),
    );
  }
}
