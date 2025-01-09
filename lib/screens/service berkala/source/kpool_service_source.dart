import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../model/mtc_model.dart';

class KpoolServiceSource extends DataGridSource {
  final List<MtcModel> model;
  final void Function(MtcModel)? onAcc;
  int startIndex = 0;

  KpoolServiceSource({
    required this.model,
    required this.onAcc,
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

    if (model.isNotEmpty) {
      cells.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                if (onAcc != null) {
                  onAcc!(model[rowIndex]);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.all(8.0),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ));
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
