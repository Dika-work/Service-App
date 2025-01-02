import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../model/detail_service_model.dart';

class ServiceBerkalaSource extends DataGridSource {
  final List<DetailServiceModel> model;
  int startIndex = 0;

  ServiceBerkalaSource({
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

    // Create cells for the first columns
    List<Widget> cells = [
      ...row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            e.value.toString(),
            textAlign: TextAlign.justify,
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
          DataGridCell<String>(columnName: 'Deskripsi\nPengecekan', value: '-'),
          DataGridCell<String>(columnName: 'KM', value: '-'),
          DataGridCell<String>(columnName: 'TARGET\n(BULAN)', value: '-'),
          DataGridCell<String>(columnName: 'TARGET\n(TAHUN)', value: '-'),
          DataGridCell<String>(columnName: 'FISIK\n(CIRI KHUSUS)', value: '-'),
          DataGridCell<String>(columnName: 'QTY\nDI KENDARAAN', value: '-'),
          DataGridCell<String>(columnName: 'Cek', value: '-'),
          DataGridCell<String>(columnName: 'Repair', value: '-'),
          DataGridCell<String>(columnName: 'Ganti', value: '-'),
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
              columnName: 'Deskripsi\nPengecekan',
              value: data.namaItem), // Ganti dengan field yang sesuai
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
              columnName: 'FISIK\n(CIRI KHUSUS)',
              value: data.kondisiFisik), // Ganti dengan field yang sesuai
          DataGridCell<String>(
              columnName: 'QTY\nDI KENDARAAN',
              value: data.quantity), // Ganti dengan field yang sesuai
          const DataGridCell<String>(
              columnName: 'Cek',
              value: 'data.cek'), // Ganti dengan field yang sesuai
          const DataGridCell<String>(
              columnName: 'Repair',
              value: 'data.repair'), // Ganti dengan field yang sesuai
          const DataGridCell<String>(
              columnName: 'Ganti',
              value: 'data.ganti'), // Ganti dengan field yang sesuai
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }
}
