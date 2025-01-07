import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../controller/mtc_controller.dart';

class AddMtcView extends GetView<MtcController> {
  const AddMtcView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryExtraSoft,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tambah Data MTC',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.createService(),
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
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding:
                const EdgeInsets.fromLTRB(CustomSize.md, 10, CustomSize.md, 0),
            physics: const BouncingScrollPhysics(),
            children: [
              TextFormField(
                controller: controller.kpoolC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Kep.Pool tidak boleh kosong';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Kep.Pool',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.noPolisiC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* No Polisi tidak boleh kosong';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('No Polisi',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.lastKmServiceC,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Bagian ini tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text('KM Terakhir Service',
                        style: Theme.of(context).textTheme.labelMedium),
                    suffixText: 'KM'),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.nowKmServiceC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Bagian ini tidak boleh kosong';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text('KM Saat Ini',
                        style: Theme.of(context).textTheme.labelMedium),
                    suffixText: 'KM'),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.nextKmServiceC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Bagian ini tidak boleh kosong';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text('KM Service Selanjutnya',
                        style: Theme.of(context).textTheme.labelMedium),
                    suffixText: 'KM'),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.jenisKenC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Jenis Mobil harus diisi';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Jenis Mobil',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.typeKenC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Type Mobil harus diisi';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Type Mobil',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.driverC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Nama Driver harus diisi';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Driver',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: controller.noBuntutC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Nomor buntut harus diisi';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('No Buntut',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
