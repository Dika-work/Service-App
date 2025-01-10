import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../model/master_kendaraan_model.dart';

class MasterKendaraanSource extends DataGridSource {
  final List<MasterKendaraanModel> model;
  int startIndex = 0;

  MasterKendaraanSource({
    required this.model,
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

    // Create cells for the first 6 columns
    List<Widget> cells = [
      ...row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: CustomSize.md),
          child: Text(
            e.value.toString(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: CustomSize.fontSizeXm),
          ),
        );
      }),
    ];

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
          DataGridCell<String>(columnName: 'Jenis Kendaraan', value: '-'),
          DataGridCell<String>(columnName: 'Merk', value: '-'),
          DataGridCell<String>(columnName: 'Type', value: '-'),
        ]);
      },
    );
  }

  void _updateDataPager(List<MasterKendaraanModel> model, int startIndex) {
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
              columnName: 'Jenis Kendaraan', value: data.jenisKen),
          DataGridCell<String>(columnName: 'Merk', value: data.merk),
          DataGridCell<String>(columnName: 'Type', value: data.type),
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }
}
