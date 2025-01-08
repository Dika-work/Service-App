import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../controller/group_user_controller.dart';
import '../model/group_user_model.dart';

class EditGroupUserView extends StatefulWidget {
  const EditGroupUserView({super.key, required this.model});

  final GroupUserModel model;

  @override
  State<EditGroupUserView> createState() => _EditGroupUserViewState();
}

class _EditGroupUserViewState extends State<EditGroupUserView> {
  late int addOption;
  late int editOpsion;
  late int deleteOpsion;

  late GroupUserController controller;

  @override
  void initState() {
    super.initState();
    addOption = int.parse(widget.model.add);
    editOpsion = int.parse(widget.model.edit);
    deleteOpsion = int.parse(widget.model.delete);
    controller = Get.find<GroupUserController>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Edit Group ${widget.model.typeUser.toUpperCase()}',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tambah data'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => addOption = 1,
                child: Row(
                  children: [
                    Radio<int?>(
                      value: 1,
                      groupValue: addOption,
                      activeColor: AppColors.primary,
                      onChanged: (value) => setState(() {
                        addOption = value!;
                      }),
                    ),
                    const Text('Yes'),
                  ],
                ),
              ),
              const SizedBox(width: CustomSize.spaceBtwItems),
              GestureDetector(
                onTap: () => addOption = 0, // Mengubah nilai menjadi 0
                child: Row(
                  children: [
                    Radio<int?>(
                      value: 0,
                      groupValue: addOption,
                      activeColor: AppColors.primary,
                      onChanged: (value) => setState(() {
                        addOption = value!;
                      }),
                    ),
                    const Text('No'),
                  ],
                ),
              ),
              const SizedBox(width: 10)
            ],
          ),
          const Text('Ubah data'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => editOpsion = 1,
                child: Row(
                  children: [
                    Radio<int?>(
                      value: 1,
                      groupValue: editOpsion,
                      activeColor: AppColors.primary,
                      onChanged: (value) => setState(() {
                        editOpsion = value!;
                      }),
                    ),
                    const Text('Yes'),
                  ],
                ),
              ),
              const SizedBox(width: CustomSize.spaceBtwItems),
              GestureDetector(
                onTap: () => editOpsion = 0, // Mengubah nilai menjadi 0
                child: Row(
                  children: [
                    Radio<int?>(
                      value: 0,
                      groupValue: editOpsion,
                      activeColor: AppColors.primary,
                      onChanged: (value) => setState(() {
                        editOpsion = value!;
                      }),
                    ),
                    const Text('No'),
                  ],
                ),
              ),
              const SizedBox(width: 10)
            ],
          ),
          const Text('Hapus data'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => deleteOpsion = 1,
                child: Row(
                  children: [
                    Radio<int?>(
                      value: 1,
                      groupValue: deleteOpsion,
                      activeColor: AppColors.primary,
                      onChanged: (value) => setState(() {
                        deleteOpsion = value!;
                      }),
                    ),
                    const Text('Yes'),
                  ],
                ),
              ),
              const SizedBox(width: CustomSize.spaceBtwItems),
              GestureDetector(
                onTap: () => deleteOpsion = 0, // Mengubah nilai menjadi 0
                child: Row(
                  children: [
                    Radio<int?>(
                      value: 0,
                      groupValue: deleteOpsion,
                      activeColor: AppColors.primary,
                      onChanged: (value) => setState(() {
                        deleteOpsion = value!;
                      }),
                    ),
                    const Text('No'),
                  ],
                ),
              ),
              const SizedBox(width: 10)
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            controller.updateGroupUser(
                id: widget.model.id,
                add: addOption.toString(),
                edit: editOpsion.toString(),
                delete: deleteOpsion.toString());
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
