import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widget/dialogs.dart';
import '../../group user/controller/group_user_controller.dart';
import '../../group user/model/group_user_model.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';
import '../source/user_source.dart';
import 'edit_user.dart';

class MasterUser extends GetView<MasterUserController> {
  const MasterUser({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupUserController groupUserController =
        Get.put(GroupUserController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Master User',
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
                  onConfirm: () async {
                    await controller.createNewUser(
                        groupUserController.selectedGroupId.value,
                        groupUserController.selectedGroupId.value);

                    groupUserController.selectedGroupId.value = '';
                  },
                  onCancel: () {
                    controller.usernameC.clear();
                    controller.passwordC.clear();
                    controller.confirmPasswordC.clear();
                    groupUserController.selectedGroupId.value = '';
                    Navigator.of(Get.overlayContext!).pop();
                  },
                  contentWidget: SingleChildScrollView(
                      child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tambah User Baru',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: CustomSize.spaceBtwInputFields),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: CustomSize.sm),
                          child: TextFormField(
                            controller: controller.usernameC,
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: CustomSize.spaceBtwInputFields),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: CustomSize.sm),
                            child: Obx(
                              () => TextFormField(
                                controller: controller.passwordC,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.obscureText.value =
                                          !(controller.obscureText.value);
                                    },
                                    icon: Icon(
                                      (controller.obscureText.value != false)
                                          ? Icons.lock
                                          : Icons.lock_open,
                                    ),
                                  ),
                                ),
                                obscureText: controller.obscureText.value,
                                validator: (value) {
                                  List<String> errors = [];

                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }

                                  if (value.length < 8) {
                                    errors.add('- At least 8 characters');
                                  }
                                  if (!value.contains(RegExp(r'[A-Z]'))) {
                                    errors.add('- At least 1 uppercase letter');
                                  }
                                  if (!value.contains(RegExp(r'[0-9]'))) {
                                    errors.add('- At least 1 number');
                                  }
                                  if (!value.contains(RegExp(r'[@$!%*?&]'))) {
                                    errors.add(
                                        '- At least 1 special character (@\$!%*?&)');
                                  }

                                  if (errors.isEmpty) {
                                    return null;
                                  }

                                  return 'Password must have:\n${errors.join('\n')}';
                                },
                              ),
                            )),

                        const SizedBox(height: CustomSize.spaceBtwInputFields),
                        // Confirm Password Field
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: CustomSize.sm),
                            child: Obx(
                              () => TextFormField(
                                controller: controller.confirmPasswordC,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.confirmObscureText.value =
                                          !(controller
                                              .confirmObscureText.value);
                                    },
                                    icon: Icon(
                                      (controller.confirmObscureText.value !=
                                              false)
                                          ? Icons.lock
                                          : Icons.lock_open,
                                    ),
                                  ),
                                ),
                                obscureText:
                                    controller.confirmObscureText.value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm Password is required';
                                  }
                                  if (value !=
                                      controller.confirmPasswordC.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        const SizedBox(height: CustomSize.spaceBtwInputFields),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: CustomSize.sm),
                          padding: const EdgeInsets.only(
                              left: CustomSize.sm, right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                CustomSize.inputFieldRadius),
                            border: Border.all(
                                width: 1, color: AppColors.borderPrimary),
                          ),
                          child: Obx(() {
                            // Menampilkan indikator loading jika data sedang dimuat
                            if (groupUserController.isLoading.value) {
                              return const CircularProgressIndicator();
                            }

                            // Menampilkan pesan jika tidak ada data
                            if (groupUserController.groupUserModel.isEmpty) {
                              return const Text('No group users available');
                            }

                            return DropdownButton<String>(
                              value: groupUserController
                                      .selectedGroupId.value.isEmpty
                                  ? null
                                  : groupUserController.selectedGroupId.value,
                              underline: const SizedBox.shrink(),
                              hint: Text(
                                'Select Group User',
                                style: const TextStyle().copyWith(
                                    fontSize: CustomSize.fontSizeSm,
                                    color: AppColors.textPrimary,
                                    fontFamily: 'Urbanist'),
                              ),
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                groupUserController.selectedGroupId.value =
                                    newValue!;
                                print(
                                    'Selected group_id: ${groupUserController.selectedGroupId.value}'); // Print group_id
                              },
                              items: groupUserController.groupUserModel
                                  .map<DropdownMenuItem<String>>(
                                      (GroupUserModel groupUser) {
                                return DropdownMenuItem<String>(
                                  value: groupUser
                                      .id, // Asumsikan GroupUserModel memiliki properti 'id'
                                  child: Text(
                                    groupUser.typeUser.toUpperCase(),
                                    style: const TextStyle().copyWith(
                                        fontSize: CustomSize.fontSizeSm,
                                        color: AppColors.textPrimary,
                                        fontFamily: 'Urbanist'),
                                  ), // Asumsikan GroupUserModel memiliki properti 'name'
                                );
                              }).toList(),
                            );
                          }),
                        ),
                      ],
                    ),
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
          )
        ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.only(top: 10.0),
        color: Colors.white,
        child: Obx(() {
          if (controller.isLoading.value && controller.userModel.isEmpty) {
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
            final dataSource = UserSource(
                model: controller.userModel,
                onEdit: (UserModel model) {
                  Get.to(() => EditUserScreen(model: model),
                      transition: Transition.fadeIn);
                },
                onDelete: (UserModel model) {
                  CustomDialogs.deleteDialog(
                      context: context,
                      onConfirm: () => controller.deleteUser(model.username));
                });

            return RefreshIndicator(
              onRefresh: () async {
                await controller.getAllUser();
              },
              child: SfDataGrid(
                source: dataSource,
                frozenColumnsCount: 2,
                rowHeight: 65,
                columnWidthMode: controller.userModel.isEmpty
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
                      columnName: 'Nama',
                      label: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.lightBlue.shade100,
                          ),
                          child: Text(
                            'Nama',
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
                  if (controller.userModel.isNotEmpty)
                    GridColumn(
                        width: 120,
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
                  if (controller.userModel.isNotEmpty)
                    GridColumn(
                        width: 120,
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
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
