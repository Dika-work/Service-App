import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../controller/service_berkala_controller.dart';
import '../source/service_berkala_source.dart';

class AddServiceBerkala extends GetView<ServiceBerkalaController> {
  const AddServiceBerkala({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Service Berkala',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: SafeArea(child: Obx(
        () {
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
                ServiceBerkalaSource(model: controller.detailServiceModel);

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
                  StackedHeaderRow(cells: [
                    StackedHeaderCell(
                      columnNames: ['Cek', 'Repair', 'Ganti', 'Status'],
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.lightBlue.shade100,
                        ),
                        child: const Text(
                          'STATUS',
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
                  GridColumn(
                      columnName: 'Cek',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'Cek',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                  GridColumn(
                      columnName: 'Repair',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'Repair',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                  GridColumn(
                      columnName: 'Ganti',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'Ganti',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
