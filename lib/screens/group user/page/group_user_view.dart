import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../controller/group_user_controller.dart';
import '../model/group_user_model.dart';
import '../source/group_user_source.dart';
import 'edit_group_user_view.dart';

class GroupUserView extends GetView<GroupUserController> {
  const GroupUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Master Group User',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //   CustomDialogs.defaultDialog(
        //       context: context,
        //       onConfirm: () => controller.createGroupUser(),
        //       onCancel: () {
        //         Navigator.of(Get.overlayContext!).pop();
        //         controller.typeUserC.clear();
        //         controller.addOpsion.value = null;
        //         controller.editOpsion.value = null;
        //         controller.deleteOpsion.value = null;
        //       },
        //       confirmText: 'Tambahkan',
        //       cancelText: 'Kembali',
        //       contentWidget: SingleChildScrollView(
        //           child: Form(
        //         key: controller.formKey,
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Center(
        //               child: Text('Tambah User Baru',
        //                   style: Theme.of(context).textTheme.titleMedium),
        //             ),
        //             const Divider(
        //               height: CustomSize.dividerHeight,
        //               thickness: .5,
        //               color: AppColors.black,
        //             ),
        //             const SizedBox(height: CustomSize.spaceBtwInputFields),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: CustomSize.sm),
        //               child: TextFormField(
        //                 controller: controller.typeUserC,
        //                 decoration:
        //                     const InputDecoration(labelText: 'Type User'),
        //                 validator: (value) {
        //                   if (value == null || value.isEmpty) {
        //                     return 'Type user tidak boleh kosong';
        //                   }
        //                   return null;
        //                 },
        //               ),
        //             ),
        //             const SizedBox(height: CustomSize.spaceBtwInputFields),
        //             const Text('Tambah data'),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 GestureDetector(
        //                   onTap: () => controller.addOpsion.value = 1,
        //                   child: Row(
        //                     children: [
        //                       Obx(
        //                         () => Radio<int?>(
        //                           value: 1,
        //                           groupValue: controller.addOpsion.value,
        //                           activeColor: AppColors.primary,
        //                           onChanged: (value) =>
        //                               controller.addOpsion.value = value,
        //                         ),
        //                       ),
        //                       const Text('Yes'),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(width: CustomSize.spaceBtwItems),
        //                 GestureDetector(
        //                   onTap: () => controller.addOpsion.value =
        //                       0, // Mengubah nilai menjadi 0
        //                   child: Row(
        //                     children: [
        //                       Obx(
        //                         () => Radio<int?>(
        //                           value: 0,
        //                           groupValue: controller.addOpsion.value,
        //                           activeColor: AppColors.primary,
        //                           onChanged: (value) =>
        //                               controller.addOpsion.value = value,
        //                         ),
        //                       ),
        //                       const Text('No'),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(width: 10)
        //               ],
        //             ),
        //             const Text('Ubah data'),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 GestureDetector(
        //                   onTap: () => controller.editOpsion.value = 1,
        //                   child: Row(
        //                     children: [
        //                       Obx(
        //                         () => Radio<int?>(
        //                           value: 1,
        //                           groupValue: controller.editOpsion.value,
        //                           activeColor: AppColors.primary,
        //                           onChanged: (value) =>
        //                               controller.editOpsion.value = value,
        //                         ),
        //                       ),
        //                       const Text('Yes'),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(width: CustomSize.spaceBtwItems),
        //                 GestureDetector(
        //                   onTap: () => controller.editOpsion.value =
        //                       0, // Mengubah nilai menjadi 0
        //                   child: Row(
        //                     children: [
        //                       Obx(
        //                         () => Radio<int?>(
        //                           value: 0,
        //                           groupValue: controller.editOpsion.value,
        //                           activeColor: AppColors.primary,
        //                           onChanged: (value) =>
        //                               controller.editOpsion.value = value,
        //                         ),
        //                       ),
        //                       const Text('No'),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(width: 10)
        //               ],
        //             ),
        //             const Text('Hapus data'),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 GestureDetector(
        //                   onTap: () => controller.deleteOpsion.value = 1,
        //                   child: Row(
        //                     children: [
        //                       Obx(
        //                         () => Radio<int?>(
        //                           value: 1,
        //                           groupValue: controller.deleteOpsion.value,
        //                           activeColor: AppColors.primary,
        //                           onChanged: (value) =>
        //                               controller.deleteOpsion.value = value,
        //                         ),
        //                       ),
        //                       const Text('Yes'),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(width: CustomSize.spaceBtwItems),
        //                 GestureDetector(
        //                   onTap: () => controller.deleteOpsion.value =
        //                       0, // Mengubah nilai menjadi 0
        //                   child: Row(
        //                     children: [
        //                       Obx(
        //                         () => Radio<int?>(
        //                           value: 0,
        //                           groupValue: controller.deleteOpsion.value,
        //                           activeColor: AppColors.primary,
        //                           onChanged: (value) =>
        //                               controller.deleteOpsion.value = value,
        //                         ),
        //                       ),
        //                       const Text('No'),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(width: 10)
        //               ],
        //             ),
        //           ],
        //         ),
        //       )));
        // },
        //     child: Container(
        //       padding: const EdgeInsets.all(CustomSize.xs),
        //       margin: const EdgeInsets.fromLTRB(
        //           0, CustomSize.sm, CustomSize.sm, CustomSize.sm),
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(CustomSize.borderRadiusSm),
        //         color: AppColors.buttonPrimary,
        //       ),
        //       child: Text(
        //         'TAMBAH',
        //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        //             fontSize: 12,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.only(top: 10.0),
        color: Colors.white,
        child: Obx(() {
          if (controller.isLoading.value && controller.groupUserModel.isEmpty) {
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
            final dataSource = GroupUserSource(
              model: controller.groupUserModel,
              onEdit: (GroupUserModel model) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return EditGroupUserView(model: model);
                  },
                );
              },
            );

            return RefreshIndicator(
              onRefresh: () async {
                await controller.getGroupUser();
              },
              child: SfDataGrid(
                  source: dataSource,
                  frozenColumnsCount: 2,
                  rowHeight: 65,
                  columnWidthMode: controller.groupUserModel.isEmpty
                      ? ColumnWidthMode.fill
                      : ColumnWidthMode.auto,
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
                        columnName: 'Type User',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Type User',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Tambah',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Tambah',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Edit',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Edit',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    GridColumn(
                        columnName: 'Hapus',
                        label: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Text(
                              'Hapus',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ))),
                    if (controller.groupUserModel.isNotEmpty)
                      GridColumn(
                          width: 120,
                          columnName: 'Ubah',
                          label: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.lightBlue.shade100,
                              ),
                              child: Text(
                                'Ubah',
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
