import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../master part service/controller/part_controller.dart';
import '../../master part service/model/part_model.dart';
import '../controller/service_berkala_controller.dart';
import '../model/detail_service_model.dart';

class EditMasterDetailServiceBerkala extends StatefulWidget {
  const EditMasterDetailServiceBerkala({super.key, required this.model});

  final DetailServiceModel model;

  @override
  State<EditMasterDetailServiceBerkala> createState() =>
      _EditDetailServiceBerkalaState();
}

class _EditDetailServiceBerkalaState
    extends State<EditMasterDetailServiceBerkala> {
  late String id;
  late TextEditingController kmTargetC;
  late TextEditingController bulanTargetC;
  late TextEditingController tahunTargetC;
  late TextEditingController kondisiFisikBagusC;
  late TextEditingController kondisiFisikJelekC;
  late TextEditingController quantityC;

  late ServiceBerkalaController controller;
  late PartController masterKategoriController;

  @override
  void initState() {
    super.initState();
    id = widget.model.id;
    kmTargetC = TextEditingController(text: widget.model.kmTarget);
    bulanTargetC = TextEditingController(text: widget.model.bulanTarget);
    tahunTargetC = TextEditingController(text: widget.model.tahunTarget);
    kondisiFisikBagusC =
        TextEditingController(text: widget.model.kondisiFisikBagus);
    kondisiFisikJelekC =
        TextEditingController(text: widget.model.kondisiFisikJelek);
    quantityC = TextEditingController(text: widget.model.quantity);

    controller = Get.find<ServiceBerkalaController>();
    masterKategoriController = Get.find<PartController>();

    // Set the initial value for the dropdown
    masterKategoriController.selectedTypeItem.value = widget.model.namaItem;
  }

  @override
  void dispose() {
    kmTargetC.dispose();
    bulanTargetC.dispose();
    tahunTargetC.dispose();
    kondisiFisikBagusC.dispose();
    kondisiFisikJelekC.dispose();
    quantityC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Center(
        child: Text(
          'Edit Detail Kategori',
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
              _buildDropdown(),
              const SizedBox(height: CustomSize.sm),
              _buildTextField(kmTargetC, 'KM Target'),
              const SizedBox(height: CustomSize.sm),
              _buildTextField(bulanTargetC, 'Target (BULAN)'),
              const SizedBox(height: CustomSize.sm),
              _buildTextField(tahunTargetC, 'Target (TAHUN)'),
              const SizedBox(height: CustomSize.sm),
              _buildTextField(kondisiFisikBagusC, 'STANDART FISIK\nBAGUS'),
              const SizedBox(height: CustomSize.sm),
              _buildTextField(kondisiFisikJelekC, 'STANDART FISIK\nJELEK'),
              const SizedBox(height: CustomSize.sm),
              _buildTextField(quantityC, 'QTY DI KENDARAAN'),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _clearFields();
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await controller.updateDetailService(
                id: id,
                namaItem: masterKategoriController.selectedTypeItem.value,
                kmTarget: kmTargetC.text,
                bulanTarget: bulanTargetC.text,
                tahunTarget: tahunTargetC.text,
                kondisiFisikBagus: kondisiFisikBagusC.text,
                kondisiFisikJelek: kondisiFisikJelekC.text,
                quantity: quantityC.text,
              );
              if (mounted) {
                Navigator.of(Get.overlayContext!).pop();
                _clearFields();
              }
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.only(left: CustomSize.sm, right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
        border: Border.all(width: 1, color: AppColors.borderPrimary),
      ),
      child: Obx(() {
        if (masterKategoriController.isLoading.value) {
          return const CircularProgressIndicator();
        }

        if (masterKategoriController.partModel.isEmpty) {
          return const Text('No group users available');
        }

        return DropdownButton<String>(
          value: masterKategoriController.selectedTypeItem.value.isEmpty
              ? null
              : masterKategoriController.selectedTypeItem.value,
          underline: const SizedBox.shrink(),
          hint: Text(
            'Nama Item',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          isExpanded: true,
          onChanged: (String? newValue) {
            masterKategoriController.selectedTypeItem.value = newValue!;
          },
          items: masterKategoriController.partModel
              .map<DropdownMenuItem<String>>((PartModel kategoriModel) {
            return DropdownMenuItem<String>(
              value: kategoriModel.namaItem,
              child: Text(
                kategoriModel.namaItem.toUpperCase(),
                style: const TextStyle().copyWith(
                    fontSize: CustomSize.fontSizeSm,
                    color: AppColors.textPrimary,
                    fontFamily: 'Urbanist'),
              ),
            );
          }).toList(),
        );
      }),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '* Bagian ini tidak boleh kosong';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(label, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }

  void _clearFields() {
    masterKategoriController.selectedTypeItem.value = '';
    kmTargetC.clear();
    bulanTargetC.clear();
    tahunTargetC.clear();
    kondisiFisikBagusC.clear();
    kondisiFisikJelekC.clear();
    quantityC.clear();
  }
}
