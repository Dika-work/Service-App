import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../group user/controller/group_user_controller.dart';
import '../../group user/model/group_user_model.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key, required this.model});

  final UserModel model;

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late String id;
  late TextEditingController username;
  // final TextEditingController password = TextEditingController();

  late GroupUserController groupUserController;
  late MasterUserController masterUserController;

  @override
  void initState() {
    super.initState();
    id = widget.model.id;
    username = TextEditingController(text: widget.model.username);

    groupUserController = Get.find<GroupUserController>();
    masterUserController = Get.find<MasterUserController>();

    // Set nilai awal dropdown berdasarkan model.type_user
    groupUserController.selectedGroupId.value = widget.model.typeUser;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // RxBool obscureText = true.obs;
    return AlertDialog(
      title: Center(
        child: Text(
          'Edit user',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: CustomSize.sm),
                child: TextFormField(
                  controller: username,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: CustomSize.spaceBtwInputFields),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: CustomSize.sm),
              //   child: Obx(
              //     () => TextFormField(
              //       controller: password,
              //       decoration: InputDecoration(
              //         labelText: 'Password',
              //         suffixIcon: IconButton(
              //           onPressed: () {
              //             obscureText.value = !(obscureText.value);
              //           },
              //           icon: Icon(
              //             (obscureText.value != false)
              //                 ? Icons.lock
              //                 : Icons.lock_open,
              //           ),
              //         ),
              //       ),
              //       obscureText: obscureText.value,
              //       validator: (value) {
              //         List<String> errors = [];

              //         if (value == null || value.isEmpty) {
              //           return 'Password is required';
              //         }

              //         if (value.length < 8) {
              //           errors.add('- At least 8 characters');
              //         }
              //         if (!value.contains(RegExp(r'[A-Z]'))) {
              //           errors.add('- At least 1 uppercase letter');
              //         }
              //         if (!value.contains(RegExp(r'[0-9]'))) {
              //           errors.add('- At least 1 number');
              //         }
              //         if (!value.contains(RegExp(r'[@$!%*?&]'))) {
              //           errors.add('- At least 1 special character (@\$!%*?&)');
              //         }

              //         if (errors.isEmpty) {
              //           return null;
              //         }

              //         return 'Password must have:\n${errors.join('\n')}';
              //       },
              //     ),
              //   ),
              // ),
              // const SizedBox(height: CustomSize.spaceBtwInputFields),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: CustomSize.sm),
                padding: const EdgeInsets.only(left: CustomSize.sm, right: 12),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(CustomSize.inputFieldRadius),
                  border: Border.all(width: 1, color: AppColors.borderPrimary),
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
                    value: groupUserController.selectedGroupId.value.isEmpty
                        ? null
                        : groupUserController.selectedGroupId.value,
                    underline: const SizedBox.shrink(),
                    hint: Text(
                      'Select Group User',
                      style: const TextStyle().copyWith(
                        fontSize: CustomSize.fontSizeSm,
                        color: AppColors.textPrimary,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      groupUserController.selectedGroupId.value = newValue!;
                      print(
                          'Selected group_id: ${groupUserController.selectedGroupId.value}');
                    },
                    items: groupUserController.groupUserModel
                        .map<DropdownMenuItem<String>>(
                            (GroupUserModel groupUser) {
                      return DropdownMenuItem<String>(
                        value: groupUser
                            .typeUser, // Menggunakan typeUser sebagai value
                        child: Text(
                          groupUser.typeUser.toUpperCase(),
                          style: const TextStyle().copyWith(
                            fontSize: CustomSize.fontSizeSm,
                            color: AppColors.textPrimary,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            username.clear();
            // password.clear();
            groupUserController.selectedGroupId.value = '';
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await masterUserController.updateUser(
                id,
                username.text,
                groupUserController.selectedGroupId.value,
                // password.text,
              );
              if (mounted) {
                Navigator.of(Get.overlayContext!).pop();
                username.clear();
                // password.clear();
                groupUserController.selectedGroupId.value = '';
              }
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
