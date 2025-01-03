import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../model/mtc_model.dart';

class AllMtcSource extends DataGridSource {
  final List<MtcModel> model;
  int startIndex = 0;

  AllMtcSource({
    required this.model,
  }) {
    _updateDataPager(model, startIndex);
  }

  List<DataGridRow> data = [];
  int index = 0;
  final localStorage = GetStorage();

  @override
  List<DataGridRow> get rows => data;

  Color _getRowColor(String status) {
    switch (status) {
      case '0':
        return Colors.pink[400]!; // Merah muda
      case '1':
        return Colors.lightBlue[400]!; // Biru muda
      case '2':
        return Colors.lightGreen[400]!; // Hijau muda
      default:
        return Colors.white; // Warna default jika status tidak dikenali
    }
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    int rowIndex = data.indexOf(row);
    String status = model[rowIndex].status; // Ambil status dari model
    Color rowColor = _getRowColor(status); // Dapatkan warna berdasarkan status

    // Create cells for the first 6 columns
    List<Widget> cells = [
      ...row.getCells().take(11).map<Widget>((e) {
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

    return DataGridRowAdapter(
      color: rowColor,
      cells: cells,
    );
  }

  List<DataGridRow> _generateEmptyRows(int count) {
    return List.generate(
      count,
      (index) {
        return const DataGridRow(cells: [
          DataGridCell<String>(columnName: 'No', value: '-'),
          DataGridCell<String>(columnName: 'Mekanik', value: '-'),
          DataGridCell<String>(columnName: 'K.Pool', value: '-'),
          DataGridCell<String>(columnName: 'No Polisi', value: '-'),
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
          DataGridCell<String>(columnName: 'Mekanik', value: data.mekanik),
          DataGridCell<String>(columnName: 'K.Pool', value: data.kpool),
          DataGridCell<String>(columnName: 'No Polisi', value: data.noPolisi),
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
}
