import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../data real/controller/data_real_controller.dart';
import '../source/edit_sb_source.dart';

class EditDetailSB extends StatefulWidget {
  const EditDetailSB({super.key, required this.idMtc});

  final String idMtc;

  @override
  State<EditDetailSB> createState() => _EditDetailSBState();
}

class _EditDetailSBState extends State<EditDetailSB> {
  late DataRealController controller;
  late String statusSerive;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DataRealController());

    controller.getData(widget.idMtc);
    statusSerive = '';
  }

  final Map<String, String> statusSeriveMap = {
    '1': 'CEK',
    '2': 'REPAIR',
    '3': 'GANTI',
  };

  String getStatusDescription(String? status) {
    switch (status) {
      case '0':
        return 'Status Tidak Jelas';
      case '1':
        return 'CEK';
      case '2':
        return 'REPAIR';
      case '3':
        return 'GANTI';
      default:
        return 'Status Tidak Diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Status Service Berkala',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.updateTransaksiDetailSb(widget.idMtc),
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
                'UBAH DATA',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.realModel.isEmpty) {
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
          final dataSource = EditSbSource(model: controller.realModel);
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getData(widget.idMtc);
            },
            child: SfDataGrid(
              source: dataSource,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              stackedHeaderRows: [
                StackedHeaderRow(cells: [
                  StackedHeaderCell(
                    columnNames: [
                      'KM',
                      'TARGET\n(BULAN)',
                      'TARGET\n(TAHUN)',
                      'KONDISI FISIK\nBAGUS',
                      'KONDISI FISIK\nJELEK',
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
                    columnNames: [
                      'Cek',
                      'Bongkar',
                      'Repair',
                      'Ganti',
                      'Status'
                    ],
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
                    columnName: 'Nama\nItem',
                    label: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.lightBlue.shade100,
                        ),
                        child: Text(
                          'Nama\nItem',
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
                    columnName: 'KONDISI FISIK\nBAGUS',
                    label: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.lightBlue.shade100,
                        ),
                        child: Text(
                          'KONDISI FISIK\nBAGUS',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ))),
                GridColumn(
                    columnName: 'KONDISI FISIK\nJELEK',
                    label: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.lightBlue.shade100,
                        ),
                        child: Text(
                          'KONDISI FISIK\nJELEK',
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
                    columnName: 'Bongkar',
                    label: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.lightBlue.shade100,
                        ),
                        child: Text(
                          'Bongkar',
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

        // return Container(
        //   width: Get.width,
        //   height: Get.height,
        //   margin: const EdgeInsets.only(top: 10.0),
        //   color: Colors.white,
        //   child: ListView.builder(
        //     itemCount: controller.realModel.length,
        //     itemBuilder: (_, index) {
        //       final data = controller.realModel[index];
        //       statusSerive = data.statusService;
        //       return Container(
        //         margin: const EdgeInsets.fromLTRB(
        //             CustomSize.sm, CustomSize.sm, CustomSize.sm, CustomSize.xs),
        //         padding: const EdgeInsets.symmetric(
        //             horizontal: CustomSize.sm, vertical: CustomSize.md),
        //         decoration: BoxDecoration(
        //             border: Border.all(width: 1, color: Colors.black)),
        //         child: Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Expanded(
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text('Nama Item',
        //                           style:
        //                               Theme.of(context).textTheme.labelMedium),
        // TextFormField(
        //   controller: TextEditingController(
        //       text:
        //           data.deskripsiPengecekan.toUpperCase()),
        //   keyboardType: TextInputType.none,
        //   readOnly: true,
        //   decoration: InputDecoration(
        //     filled: true,
        //     fillColor: AppColors.buttonDisabled,
        //   ),
        // ),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(width: CustomSize.sm),
        //                 Expanded(
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text('KM STANDART',
        //                           style:
        //                               Theme.of(context).textTheme.labelMedium),
        //                       TextFormField(
        //                         controller:
        //                             TextEditingController(text: data.kmTarget),
        //                         keyboardType: TextInputType.none,
        //                         readOnly: true,
        //                         decoration: InputDecoration(
        //                           filled: true,
        //                           fillColor: AppColors.buttonDisabled,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             ),
        //             const SizedBox(height: CustomSize.sm),
        //             Row(
        //               children: [
        //                 Expanded(
        //                     child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('TARGET (BULAN)',
        //                         style: Theme.of(context).textTheme.labelMedium),
        //                     TextFormField(
        //                       controller:
        //                           TextEditingController(text: data.bulanTarget),
        //                       keyboardType: TextInputType.none,
        //                       readOnly: true,
        //                       decoration: InputDecoration(
        //                         filled: true,
        //                         fillColor: AppColors.buttonDisabled,
        //                       ),
        //                     ),
        //                   ],
        //                 )),
        //                 const SizedBox(width: CustomSize.sm),
        //                 Expanded(
        //                     child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('Target (TAHUN)',
        //                         style: Theme.of(context).textTheme.labelMedium),
        //                     TextFormField(
        //                       controller:
        //                           TextEditingController(text: data.tahunTarget),
        //                       keyboardType: TextInputType.none,
        //                       readOnly: true,
        //                       decoration: InputDecoration(
        //                         filled: true,
        //                         fillColor: AppColors.buttonDisabled,
        //                       ),
        //                     ),
        //                   ],
        //                 )),
        //               ],
        //             ),
        //             const SizedBox(height: CustomSize.sm),
        //             Align(
        //               alignment: Alignment.centerLeft,
        //               child: Text('KONDISI FISIK BAGUS',
        //                   style: Theme.of(context).textTheme.labelMedium),
        //             ),
        //             TextFormField(
        //               controller: TextEditingController(
        //                   text: data.kondisiFisikBagus.toUpperCase()),
        //               keyboardType: TextInputType.none,
        //               readOnly: true,
        //               maxLines: 10,
        //               minLines: 1,
        //               decoration: InputDecoration(
        //                 filled: true,
        //                 fillColor: AppColors.buttonDisabled,
        //               ),
        //             ),
        //             const SizedBox(height: CustomSize.sm),
        //             Align(
        //               alignment: Alignment.centerLeft,
        //               child: Text('KONDISI FISIK JELEK',
        //                   style: Theme.of(context).textTheme.labelMedium),
        //             ),
        //             TextFormField(
        //               controller: TextEditingController(
        //                   text: data.kondisiFisikJelek.toUpperCase()),
        //               keyboardType: TextInputType.none,
        //               readOnly: true,
        //               maxLines: 10,
        //               minLines: 1,
        //               decoration: InputDecoration(
        //                 filled: true,
        //                 fillColor: AppColors.buttonDisabled,
        //               ),
        //             ),
        //             const SizedBox(height: CustomSize.sm),
        //             Row(
        //               children: [
        //                 Expanded(
        //                     child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('QTY DI KENDARAAN',
        //                         style: Theme.of(context).textTheme.labelMedium),
        //                     TextFormField(
        //                       controller: TextEditingController(
        //                           text: data.quantity.toUpperCase()),
        //                       keyboardType: TextInputType.none,
        //                       readOnly: true,
        //                       decoration: InputDecoration(
        //                         filled: true,
        //                         fillColor: AppColors.buttonDisabled,
        //                       ),
        //                     ),
        //                   ],
        //                 )),
        //                 const SizedBox(width: CustomSize.sm),
        //                 Expanded(
        //                     child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('STATUS SERVICE',
        //                         style: Theme.of(context).textTheme.labelMedium),
        //                     Container(
        //                       padding: const EdgeInsets.only(
        //                           left: CustomSize.sm, right: 12),
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(
        //                             CustomSize.inputFieldRadius),
        //                         border: Border.all(
        //                             width: 1, color: AppColors.borderPrimary),
        //                       ),
        //                       child: DropdownButton<String>(
        //                         value: statusSerive,
        //                         underline: const SizedBox.shrink(),
        //                         isExpanded: true,
        //                         onChanged: (String? newValue) {
        //                           setState(() {
        //                             statusSerive = newValue!;
        //                             controller.realModel[index].statusService =
        //                                 newValue;
        //                             print(
        //                                 'Selected statusSerive: $statusSerive');
        //                           });
        //                         },
        //                         items: statusSeriveMap.entries
        //                             .map(
        //                               (entry) => DropdownMenuItem<String>(
        //                                 value: entry.key,
        //                                 child: Text(entry.value),
        //                               ),
        //                             )
        //                             .toList(),
        //                       ),
        //                     ),
        //                   ],
        //                 ))
        //                 // Expanded(
        //                 //     child: TextFormField(
        //                 //   controller: TextEditingController(
        //                 //       text: getStatusDescription(data.statusService)),
        //                 //   keyboardType: TextInputType.none,
        //                 //   readOnly: true,
        //                 //   decoration: InputDecoration(
        //                 //     label: Text('STATUS',
        //                 //         style: Theme.of(context).textTheme.labelMedium),
        //                 //   ),
        //                 // )),
        //               ],
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // );
      }),
    );
  }
}
