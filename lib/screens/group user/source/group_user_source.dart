import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../model/group_user_model.dart';

class GroupUserSource extends DataGridSource {
  final List<GroupUserModel> model;
  final void Function(GroupUserModel)? onEdit;
  int startIndex = 0;

  GroupUserSource({
    required this.model,
    required this.onEdit,
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
      ...row.getCells().take(5).map<Widget>((e) {
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
                if (onEdit != null) {
                  onEdit!(model[rowIndex]);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.all(8.0),
              ),
              child: const Icon(Iconsax.edit),
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
          DataGridCell<String>(columnName: 'Type User', value: '-'),
          DataGridCell<String>(columnName: 'Tambah', value: '-'),
          DataGridCell<String>(columnName: 'Edit', value: '-'),
          DataGridCell<String>(columnName: 'Hapus', value: '-'),
        ]);
      },
    );
  }

  void _updateDataPager(List<GroupUserModel> model, int startIndex) {
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
          DataGridCell<String>(columnName: 'Type User', value: data.typeUser),
          DataGridCell<String>(
              columnName: 'Tambah', value: data.add == '1' ? 'YES' : 'NO'),
          DataGridCell<String>(
              columnName: 'Edit', value: data.edit == '1' ? 'YES' : 'NO'),
          DataGridCell<String>(
              columnName: 'Hapus', value: data.delete == '1' ? 'YES' : 'NO'),
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }
}
