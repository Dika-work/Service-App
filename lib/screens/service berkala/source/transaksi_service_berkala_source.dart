import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../model/detail_service_model.dart';

class TransaksiServiceBerkalaSource extends DataGridSource {
  final List<DetailServiceModel> model;
  int startIndex = 0;

  TransaksiServiceBerkalaSource({
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
    DetailServiceModel currentModel = model[rowIndex];

    return DataGridRowAdapter(
      color: isEvenRow ? Colors.white : Colors.grey[200],
      cells: [
        // Kolom 0 sampai 8
        ...row.getCells().sublist(0, 8).map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              e.value.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: CustomSize.fontSizeXm),
            ),
          );
        }),
        // Kolom radio button dan KETERANGAN
        ...row.getCells().sublist(8).map<Widget>((e) {
          if (e.columnName == 'Cek' ||
              e.columnName == 'Bongkar' ||
              e.columnName == 'Repair' ||
              e.columnName == 'Ganti') {
            // Radio button logic
            return Container(
              alignment: Alignment.center,
              child: Radio<String?>(
                value: e.value.toString(),
                groupValue: currentModel.selectedOption,
                onChanged: (value) {
                  _updateSelectedOption(rowIndex, value!);
                },
              ),
            );
          } else {
            // Default untuk kolom lain seperti 'KETERANGAN'
            return Center(
              child: Text(
                e.value.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: CustomSize.fontSizeXm),
              ),
            );
          }
        }),
      ],
    );
  }

  void _updateSelectedOption(int rowIndex, String selectedOption) {
    model[rowIndex].selectedOption = selectedOption;
    print('Row $rowIndex updated: selectedValue = $selectedOption');
    notifyListeners(); // Memperbarui tampilan DataGrid
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
          DataGridCell<String>(columnName: 'STANDART FISIK\nJELEK', value: '-'),
          DataGridCell<String>(columnName: 'QTY\nDI KENDARAAN', value: '-'),
          DataGridCell<String>(columnName: 'Cek', value: '-'),
          DataGridCell<String>(columnName: 'Bongkar', value: '-'),
          DataGridCell<String>(columnName: 'Repair', value: '-'),
          DataGridCell<String>(columnName: 'Ganti', value: '-'),
          DataGridCell<String>(columnName: 'KETERANGAN', value: '-'),
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
              columnName: 'Nama\nItem', value: data.namaItem.toUpperCase()),
          DataGridCell<String>(columnName: 'KM', value: data.kmTarget),
          DataGridCell<String>(
              columnName: 'TARGET\n(BULAN)', value: data.bulanTarget),
          DataGridCell<String>(
              columnName: 'TARGET\n(TAHUN)', value: data.tahunTarget),
          DataGridCell<String>(
              columnName: 'KONDISI FISIK\nBAGUS',
              value: data.kondisiFisikBagus.toUpperCase()),
          DataGridCell<String>(
              columnName: 'STANDART FISIK\nJELEK',
              value: data.kondisiFisikJelek.toUpperCase()),
          DataGridCell<String>(
              columnName: 'QTY\nDI KENDARAAN',
              value: data.quantity.toUpperCase()),
          const DataGridCell<String>(columnName: 'Cek', value: '1'),
          const DataGridCell<String>(columnName: 'Bongkar', value: '2'),
          const DataGridCell<String>(columnName: 'Repair', value: '3'),
          const DataGridCell<String>(columnName: 'Ganti', value: '4'),
          DataGridCell<String>(
              columnName: 'KETERANGAN', value: data.keterangan.toUpperCase()),
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }
}
