import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../master type item/controller/master_type_item_controller.dart';
import '../../master type item/model/master_type_item_model.dart';
import '../controller/part_controller.dart';
import '../model/part_model.dart';

class EditPartMaster extends StatefulWidget {
  const EditPartMaster({super.key, required this.model});

  final PartModel model;

  @override
  State<EditPartMaster> createState() => _EditPartMasterState();
}

class _EditPartMasterState extends State<EditPartMaster> {
  late TextEditingController namaItemC;
  late String selectedTypeItem;

  late PartController controller;
  late MasterTypeItemController masterTypeItemController;

  @override
  void initState() {
    super.initState();
    namaItemC = TextEditingController(text: widget.model.namaItem);
    selectedTypeItem = widget.model.typeItem;
    controller = Get.find<PartController>();
    masterTypeItemController = Get.find<MasterTypeItemController>();
  }

  @override
  void dispose() {
    super.dispose();
    namaItemC.clear();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Center(
        child: Text(
          'Edit Part',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaItemC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Nama item tidak boleh kosong';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Nama Item',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              Obx(() {
                if (masterTypeItemController.isLoading.value) {
                  return const CircularProgressIndicator();
                }

                return DropdownButtonFormField<String>(
                  value: selectedTypeItem,
                  isExpanded: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Type Item',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTypeItem = newValue!;
                      print(
                          'ini nilai terbaru dari id type kategori yg di pilih: $selectedTypeItem');
                    });
                  },
                  items: masterTypeItemController.masterTypeItemModel
                      .map<DropdownMenuItem<String>>(
                          (MasterTypeItemModel typeItem) {
                    return DropdownMenuItem<String>(
                      value: typeItem.typeItem,
                      child: Text(typeItem.typeItem.toUpperCase()),
                    );
                  }).toList(),
                );
              }),
            ],
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Kembali')),
        TextButton(
            onPressed: () {
              controller.updatePart(
                  id: widget.model.id,
                  namaItem: namaItemC.text.trim(),
                  typeItem: selectedTypeItem);
            },
            child: const Text('Perbaharui')),
      ],
    );
  }
}
