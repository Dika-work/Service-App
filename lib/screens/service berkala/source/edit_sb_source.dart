import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../data real/model/data_real_model.dart';

class EditSbSource extends DataGridSource {
  final List<DataRealModel> model;
  int startIndex = 0;

  EditSbSource({
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
    DataRealModel currentModel = model[rowIndex];

    return DataGridRowAdapter(
      color: isEvenRow ? Colors.white : Colors.grey[200],
      cells: [
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
        // Radio button for Cek
        Container(
          alignment: Alignment.center,
          child: Radio<String?>(
            value: '1',
            groupValue: currentModel.statusService,
            onChanged: (value) {
              _updateSelectedOption(rowIndex, value!);
            },
          ),
        ),
        // Radio button for Bongkar
        Container(
          alignment: Alignment.center,
          child: Radio<String?>(
            value: '2',
            groupValue: currentModel.statusService,
            onChanged: (value) {
              _updateSelectedOption(rowIndex, value!);
            },
          ),
        ),
        // Radio button for Repair
        Container(
          alignment: Alignment.center,
          child: Radio<String?>(
            value: '3',
            groupValue: currentModel.statusService,
            onChanged: (value) {
              _updateSelectedOption(rowIndex, value!);
            },
          ),
        ),
        // Radio button for Ganti
        Container(
          alignment: Alignment.center,
          child: Radio<String?>(
            value: '4',
            groupValue: currentModel.statusService,
            onChanged: (value) {
              _updateSelectedOption(rowIndex, value!);
            },
          ),
        ),
      ],
    );
  }

  void _updateSelectedOption(int rowIndex, String selectedOption) {
    model[rowIndex].statusService = selectedOption;
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
        ]);
      },
    );
  }

  void _updateDataPager(List<DataRealModel> model, int startIndex) {
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
              value: data.deskripsiPengecekan.toUpperCase()),
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
          const DataGridCell<String>(columnName: 'Bongkar', value: '1'),
          const DataGridCell<String>(columnName: 'Repair', value: '2'),
          const DataGridCell<String>(columnName: 'Ganti', value: '3'),
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }
}
