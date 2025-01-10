import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../model/mtc_model.dart';

class MtcSource extends DataGridSource {
  final List<MtcModel> model;
  final void Function(MtcModel)? onServis;
  final void Function(MtcModel)? onEdit;
  final void Function(MtcModel)? onDelete;
  int startIndex = 0;

  MtcSource({
    required this.model,
    required this.onServis,
    required this.onEdit,
    required this.onDelete,
  }) {
    _updateDataPager(model, startIndex);
  }

  List<DataGridRow> data = [];
  int index = 0;
  final localStorage = GetStorage();

  @override
  List<DataGridRow> get rows => data;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    int rowIndex = data.indexOf(row);
    bool isEvenRow = rowIndex % 2 == 0;
    final canAdd = localStorage.read('add');
    final canEdit = localStorage.read('edit');
    final canDelete = localStorage.read('delete');
    final typeUser = localStorage.read('type_user');

    // Create cells for the first 6 columns
    List<Widget> cells = [
      ...row.getCells().take(12).map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: CustomSize.md),
          child: Text(
            e.value.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: CustomSize.fontSizeXm),
          ),
        );
      }),
    ];

    if (model.isNotEmpty) {
      if (canAdd == '1') {
        cells.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (model[rowIndex].status == '0')
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (onServis != null) {
                      onServis!(model[rowIndex]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Icon(
                    Iconsax.add,
                    color: Colors.white,
                  ),
                ),
              ),
            if (model[rowIndex].status == '1')
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (onServis != null) {
                      onServis!(model[rowIndex]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Text(
                    'DETAIL\nSB',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (model[rowIndex].status == '2' &&
                (typeUser == 'mekanik' || typeUser == 'pic'))
              const Icon(Icons.check),
            if (model[rowIndex].status == '3' &&
                (typeUser == 'admin' || typeUser == 'staff'))
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (onServis != null) {
                      onServis!(model[rowIndex]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Text(
                    'ACC',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ));
      }

      if (canEdit == '1') {
        cells.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (model[rowIndex].status == '0')
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (onEdit != null) {
                      onEdit!(model[rowIndex]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Icon(
                    Iconsax.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            if (model[rowIndex].status == '1')
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (onEdit != null) {
                      onEdit!(model[rowIndex]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Text(
                    'EDIT\nSB',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (model[rowIndex].status == '2') const Icon(Icons.check),
            // if (model[rowIndex].status == '2' && typeUser == 'mekanik')
            //   const Icon(Icons.check),
            // if (model[rowIndex].status == '2' &&
            //     (typeUser == 'admin' || typeUser == 'staff'))
            //   SizedBox(
            //     height: 60,
            //     width: 100,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         if (onServis != null) {
            //           onServis!(model[rowIndex]);
            //         }
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.warning,
            //         padding: const EdgeInsets.all(8.0),
            //       ),
            //       child: const Text(
            //         'EDIT',
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   ),
          ],
        ));
      }

      if (canDelete == '1') {
        cells.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (model[rowIndex].status == '0')
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (onDelete != null) {
                      onDelete!(model[rowIndex]);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Icon(
                    Iconsax.trash,
                    color: Colors.white,
                  ),
                ),
              ),
            if (model[rowIndex].status == '1') const SizedBox.shrink(),
            if (model[rowIndex].status == '2') const Icon(Icons.check)
          ],
        ));
      }
    }
    return DataGridRowAdapter(
      color: isEvenRow ? Colors.white : Colors.grey[200],
      cells: cells,
    );
  }

  List<DataGridRow> _generateEmptyRows(int count) {
    return List.generate(
      count,
      (index) {
        return const DataGridRow(cells: [
          DataGridCell<String>(columnName: 'No', value: '-'),
          DataGridCell<String>(columnName: 'Tgl Dibuat', value: '-'),
          DataGridCell<String>(columnName: 'No Polisi', value: '-'),
          DataGridCell<String>(columnName: 'Mekanik', value: '-'),
          DataGridCell<String>(columnName: 'K.Pool', value: '-'),
          DataGridCell<String>(columnName: 'KM Terakhir Servis', value: '-'),
          DataGridCell<String>(columnName: 'KM Saat Ini', value: '-'),
          DataGridCell<String>(columnName: 'KM Servis Selanjutnya', value: '-'),
          DataGridCell<String>(columnName: 'Jenis Mobil', value: '-'),
          DataGridCell<String>(columnName: 'Type Mobil', value: '-'),
          DataGridCell<String>(columnName: 'Driver', value: '-'),
          DataGridCell<String>(columnName: 'No Buntut', value: '-'),
        ]);
      },
    );
  }

  void _updateDataPager(List<MtcModel> model, int startIndex) {
    this.startIndex = startIndex;
    index = startIndex;

    if (model.isEmpty) {
      data = _generateEmptyRows(1);
    } else {
      data = model.skip(startIndex).map<DataGridRow>((data) {
        index++;
        // Create row cells
        List<DataGridCell> cells = [
          DataGridCell<int>(columnName: 'No', value: index),
          DataGridCell<String>(
              columnName: 'Tgl Dibuat',
              value:
                  DateFormat('d/MMM/y').format(DateTime.parse(data.createAt))),
          DataGridCell<String>(columnName: 'No Polisi', value: data.noPolisi),
          DataGridCell<String>(
              columnName: 'Mekanik', value: data.mekanik.toUpperCase()),
          DataGridCell<String>(
              columnName: 'K.Pool', value: data.kpool.toUpperCase()),
          DataGridCell<String>(
              columnName: 'KM Terakhir Servis', value: data.lastService),
          DataGridCell<String>(columnName: 'KM Saat Ini', value: data.nowKm),
          DataGridCell<String>(
              columnName: 'KM Servis Selanjutnya', value: data.nextService),
          DataGridCell<String>(columnName: 'Jenis Mobil', value: data.jenisKen),
          DataGridCell<String>(columnName: 'Type Mobil', value: data.typeKen),
          DataGridCell<String>(columnName: 'Driver', value: data.driver),
          DataGridCell<String>(columnName: 'No Buntut', value: data.noBuntut),
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    _updateDataPager(model, newPageIndex);
    notifyListeners();
    return true;
  }
}
