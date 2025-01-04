import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../home/controller/home_super_admin_controller.dart';
import '../model/mtc_model.dart';

class EditServiceBerkala extends StatefulWidget {
  const EditServiceBerkala({super.key, required this.model});

  final MtcModel model;

  @override
  State<EditServiceBerkala> createState() => _EditServiceBerkalaState();
}

class _EditServiceBerkalaState extends State<EditServiceBerkala> {
  late TextEditingController mekanikC;
  late TextEditingController kpoolC;
  late TextEditingController noPolisiC;
  late TextEditingController lastKmServiceC;
  late TextEditingController nowKmServiceC;
  late TextEditingController nextKmServiceC;
  late TextEditingController jenisKenC;
  late TextEditingController typeKenC;
  late TextEditingController driverC;
  late TextEditingController noBuntutC;

  late HomeSuperAdminController controller;

  @override
  void initState() {
    super.initState();
    mekanikC = TextEditingController(text: widget.model.mekanik);
    kpoolC = TextEditingController(text: widget.model.kpool);
    noPolisiC = TextEditingController(text: widget.model.noPolisi);
    lastKmServiceC = TextEditingController(text: widget.model.lastService);
    nowKmServiceC = TextEditingController(text: widget.model.nowKm);
    nextKmServiceC = TextEditingController(text: widget.model.nextService);
    jenisKenC = TextEditingController(text: widget.model.jenisKen);
    typeKenC = TextEditingController(text: widget.model.typeKen);
    driverC = TextEditingController(text: widget.model.driver);
    noBuntutC = TextEditingController(text: widget.model.noBuntut);

    controller = Get.find<HomeSuperAdminController>();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Edit Service Berkala',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.updateService(
                  idMtc: widget.model.id,
                  mekanik: mekanikC.text,
                  kpool: kpoolC.text,
                  noPolisi: noPolisiC.text,
                  lastService: lastKmServiceC.text,
                  nowKm: nowKmServiceC.text,
                  nextService: nextKmServiceC.text,
                  jenisKen: jenisKenC.text,
                  typeKen: typeKenC.text,
                  driver: driverC.text,
                  noBuntut: noBuntutC.text);
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
                'PERBAHARUI',
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
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                CustomSize.md, CustomSize.md, CustomSize.md, 0),
            children: [
              TextFormField(
                controller: mekanikC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '* Mekanik tidak boleh kosong';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Mekanik',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
              const SizedBox(height: CustomSize.sm),
              TextFormField(
                controller: kpoolC,
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
                controller: noPolisiC,
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
                controller: lastKmServiceC,
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
                controller: nowKmServiceC,
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
                controller: nextKmServiceC,
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
                controller: jenisKenC,
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
                controller: typeKenC,
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
                controller: driverC,
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
                controller: noBuntutC,
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
