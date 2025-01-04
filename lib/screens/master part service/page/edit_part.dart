import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
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
  late TextEditingController typeC;

  late PartController controller;

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    namaItemC = TextEditingController(text: widget.model.namaItem);
    typeC = TextEditingController(text: capitalize(widget.model.typeItem));

    controller = Get.find<PartController>();
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
              TextFormField(
                controller: typeC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Type item tidak boleh kosong';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Type Item',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
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
                  typeItem: typeC.text.trim());
            },
            child: const Text('Perbaharui')),
      ],
    );
  }
}
