import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:service/constant/custom_size.dart';
import 'package:service/utils/theme/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/user_model.dart';

class UserSource extends DataGridSource {
  final List<UserModel> model;
  final void Function(UserModel)? onEdit;
  final void Function(UserModel)? onDelete;
  int startIndex = 0;

  UserSource({
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

    // Create cells for the first 6 columns
    List<Widget> cells = [
      ...row.getCells().take(3).map<Widget>((e) {
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
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.all(8.0),
              ),
              child: const Icon(Iconsax.trash),
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
          DataGridCell<String>(columnName: 'Nama', value: '-'),
          DataGridCell<String>(columnName: 'Type User', value: '-'),
        ]);
      },
    );
  }

  void _updateDataPager(List<UserModel> model, int startIndex) {
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
          DataGridCell<String>(columnName: 'Nama', value: data.username),
          DataGridCell<String>(columnName: 'Type User', value: data.typeUser),
        ];

        return DataGridRow(cells: cells);
      }).toList();
    }

    notifyListeners();
  }
}
