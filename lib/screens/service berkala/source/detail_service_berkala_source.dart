import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../model/detail_service_model.dart';

class DetailServiceBerkalaSource extends DataGridSource {
  final List<DetailServiceModel> model;
  final void Function(DetailServiceModel)? onEdit;
  final void Function(DetailServiceModel)? onDelete;

  int startIndex = 0;

  DetailServiceBerkalaSource({
    required this.model,
    required this.onEdit,
    required this.onDelete,
  }) {
    _updateDataPager(model, startIndex);
  }

  List<DataGridRow> data = [];
  int index = 0;

  @override
  List<DataGridRow> get rows => data;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    int rowIndex = data.indexOf(row);
    bool isEvenRow = rowIndex % 2 == 0;

    // Create cells for the first columns
    List<Widget> cells = [
      ...row.getCells().map<Widget>((e) {
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
      // Add Edit Button
      cells.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                Icons.edit,
                color: Colors.white,
              ),
            ),
          )
        ],
      ));
    }

    if (model.isNotEmpty) {
      // Add Delete Button
      cells.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                backgroundColor: AppColors.error,
                padding: const EdgeInsets.all(8.0),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          )
        ],
      ));
    }

    print('Jumlah sel: ${cells.length}');
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
          DataGridCell<String>(columnName: 'Nama\nItem', value: '-'),
          DataGridCell<String>(columnName: 'KM', value: '-'),
          DataGridCell<String>(columnName: 'TARGET\n(BULAN)', value: '-'),
          DataGridCell<String>(columnName: 'TARGET\n(TAHUN)', value: '-'),
          DataGridCell<String>(columnName: 'KONDISI FISIK\nBAGUS', value: '-'),
          DataGridCell<String>(columnName: 'KONDISI FISIK\nJELEK', value: '-'),
          DataGridCell<String>(columnName: 'QTY\nDI KENDARAAN', value: '-'),
        ]);
      },
    );
  }

  void _updateDataPager(List<DetailServiceModel> model, int startIndex) {
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
              columnName: 'Nama\nItem',
              value: data.namaItem
                  .toUpperCase()), // Ganti dengan field yang sesuai
          DataGridCell<String>(
              columnName: 'KM',
              value: data.kmTarget), // Ganti dengan field yang sesuai
          DataGridCell<String>(
              columnName: 'TARGET\n(BULAN)',
              value: data.bulanTarget), // Ganti dengan field yang sesuai
          DataGridCell<String>(
              columnName: 'TARGET\n(TAHUN)',
              value: data.tahunTarget), // Ganti dengan field yang sesuai
          DataGridCell<String>(
              columnName: 'KONDISI FISIK\nBAGUS',
              value: data.kondisiFisikBagus
                  .toUpperCase()), // Ganti dengan field yang sesuai
          DataGridCell<String>(
              columnName: 'KONDISI FISIK\nJELEK',
              value: data.kondisiFisikJelek
                  .toUpperCase()), // Ganti dengan field yang sesuai
          DataGridCell<String>(
              columnName: 'QTY\nDI KENDARAAN',
              value: data.quantity
                  .toUpperCase()), // Ganti dengan field yang sesuai
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }
}
