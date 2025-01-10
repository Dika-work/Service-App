import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/utils/widget/dialogs.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../controller/master_type_item_controller.dart';
import '../source/master_type_item_source.dart';

class MasterTypeItemView extends GetView<MasterTypeItemController> {
  const MasterTypeItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Master Type Kategori',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              CustomDialogs.defaultDialog(
                  context: context,
                  onConfirm: () => controller.createTypeItem(),
                  titleWidget: Center(
                    child: Text(
                      'Tambah Type Kategori',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                  contentWidget: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.typeKategoriC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Type item tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('Type Item',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ],
                      )));
            },
            child: Container(
              padding: const EdgeInsets.all(CustomSize.xs),
              margin: const EdgeInsets.fromLTRB(
                  0, CustomSize.sm, CustomSize.sm, CustomSize.sm),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomSize.borderRadiusSm),
                color: AppColors.buttonPrimary,
              ),
              child: Text(
                'TAMBAH',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.only(top: 10.0),
        color: Colors.white,
        child: Obx(() {
          if (controller.isLoading.value &&
              controller.masterTypeItemModel.isEmpty) {
            return Center(
              child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(CustomSize.sm),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            );
          } else {
            final dataSource = MasterTypeItemSource(
              model: controller.masterTypeItemModel,
            );

            return RefreshIndicator(
              onRefresh: () async {},
              child: SfDataGrid(
                  source: dataSource,
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columns: [
                    GridColumn(
                        width: 50,
                        columnName: 'No',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'No',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Type Item',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Type Item',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                  ]),
            );
          }
        }),
      ),
    );
  }
}
