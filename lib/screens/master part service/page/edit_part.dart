import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/widget/dropdown.dart';
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
  late String type;

  late PartController controller;

  final List<String> typeMap = [
    'Pelumas',
    'Filter',
    'Mesin',
    'Accesories',
    'Kaki-Kaki',
    'Radiator',
    'Power Stearing',
    'Wiper Kaca',
    'Rem Tangan',
    'Perseneling',
    'Cylinder Head',
    'Gardan',
    'Cross Joint',
    'Fantbelt',
    'Joint Kopel Belakang',
    'Lock Buntut',
    'Piringan Lock Buntut',
    'Kaki-Kaki Belakang',
    'Selang Spiral (Merah-Kuning)',
    'Ban(Tekanan Angin)'
  ];

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    namaItemC = TextEditingController(text: widget.model.namaItem);
    type = capitalize(widget.model.typeItem);

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
                  label: Text('Nama item',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              DropDownWidget(
                value: type,
                items: typeMap,
                widthDropdownValue: 305,
                onChanged: (String? value) {
                  setState(() {
                    type = value!;
                  });
                },
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
                  typeItem: type.toLowerCase());
            },
            child: const Text('Perbaharui')),
      ],
    );
  }
}
