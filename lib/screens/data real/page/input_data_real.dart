import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../controller/data_real_controller.dart';

class InputDataReal extends StatefulWidget {
  const InputDataReal({super.key, required this.idMtc});

  final String idMtc;

  @override
  State<InputDataReal> createState() => _InputDataRealState();
}

class _InputDataRealState extends State<InputDataReal> {
  late DataRealController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DataRealController());

    controller.getData(widget.idMtc);
  }

  String getStatusDescription(String? status) {
    switch (status) {
      case '0':
        return 'Status Tidak Jelas';
      case '1':
        return 'CEK';
      case '2':
        return 'BONGKAR';
      case '3':
        return 'REPAIR';
      case '4':
        return 'GANTI';
      default:
        return 'Status Tidak Diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'INPUT DATA REAL',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.updateTransaksi(),
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
                'TAMBAHKAN',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.realModel.isEmpty) {
          return const Center(child: Text("Tidak ada data"));
        }

        return Container(
          width: Get.width,
          height: Get.height,
          margin: const EdgeInsets.only(top: 10.0),
          color: Colors.white,
          child: ListView.builder(
            itemCount: controller.realModel.length,
            itemBuilder: (context, index) {
              final data = controller.realModel[index];
              return Container(
                margin: const EdgeInsets.fromLTRB(
                    CustomSize.sm, CustomSize.sm, CustomSize.sm, CustomSize.xs),
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomSize.sm, vertical: CustomSize.md),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: Column(
                  children: [
                    Text(
                      'STANDART SERVICE',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                    const Divider(height: CustomSize.dividerHeight),
                    Padding(
                      padding: const EdgeInsets.only(top: CustomSize.sm),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama Item',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextFormField(
                                controller: TextEditingController(
                                    text:
                                        data.deskripsiPengecekan.toUpperCase()),
                                keyboardType: TextInputType.none,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.buttonDisabled,
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(width: CustomSize.sm),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('KM STANDART',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              TextFormField(
                                controller:
                                    TextEditingController(text: data.kmTarget),
                                keyboardType: TextInputType.none,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.buttonDisabled,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: CustomSize.sm),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TARGET (BULAN)',
                                style: Theme.of(context).textTheme.labelMedium),
                            TextFormField(
                              controller:
                                  TextEditingController(text: data.bulanTarget),
                              keyboardType: TextInputType.none,
                              readOnly: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColors.buttonDisabled,
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(width: CustomSize.sm),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Target (TAHUN)',
                                style: Theme.of(context).textTheme.labelMedium),
                            TextFormField(
                              controller:
                                  TextEditingController(text: data.tahunTarget),
                              keyboardType: TextInputType.none,
                              readOnly: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColors.buttonDisabled,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: CustomSize.sm),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('KONDISI FISIK BAGUS',
                          style: Theme.of(context).textTheme.labelMedium),
                    ),
                    TextFormField(
                      controller: TextEditingController(
                          text: data.kondisiFisikBagus.toUpperCase()),
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      maxLines: 10,
                      minLines: 1,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.buttonDisabled,
                      ),
                    ),
                    const SizedBox(height: CustomSize.sm),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('KONDISI FISIK JELEK',
                          style: Theme.of(context).textTheme.labelMedium),
                    ),
                    TextFormField(
                      controller: TextEditingController(
                          text: data.kondisiFisikJelek.toUpperCase()),
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      maxLines: 10,
                      minLines: 1,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.buttonDisabled,
                      ),
                    ),
                    const SizedBox(height: CustomSize.sm),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text('QTY DI KENDARAAN',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                            TextFormField(
                              controller: TextEditingController(
                                  text: data.quantity.toUpperCase()),
                              keyboardType: TextInputType.none,
                              readOnly: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColors.buttonDisabled,
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(width: CustomSize.sm),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('STATUS',
                                style: Theme.of(context).textTheme.labelMedium),
                            TextFormField(
                              controller: TextEditingController(
                                  text:
                                      getStatusDescription(data.statusService)),
                              keyboardType: TextInputType.none,
                              readOnly: true,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColors.buttonDisabled,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    if (data.statusService == '4')
                      const SizedBox(height: CustomSize.sm),
                    if (data.statusService == '4')
                      Text(
                        'STANDART SERVICE',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                      ),
                    const Divider(height: CustomSize.dividerHeight),
                    if (data.statusService == '4')
                      Padding(
                        padding: const EdgeInsets.only(top: CustomSize.sm),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('KM',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  TextFormField(
                                    controller:
                                        controller.kmRealControllers[index],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '* Bagian ini tidak boleh kosong';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: CustomSize.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('WAKTU (BULAN)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  TextFormField(
                                    controller: controller
                                        .waktuBulanRealControllers[index],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '* Bagian ini tidak boleh kosong';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (data.statusService == '4')
                      const SizedBox(height: CustomSize.sm),
                    if (data.statusService == '4')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('FISIK (CIRI KHUSUS)',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    if (data.statusService == '4')
                      TextFormField(
                        controller:
                            controller.kondisiFisikRealControllers[index],
                        maxLines: 10,
                        minLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Bagian ini tidak boleh kosong';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                    if (data.statusService == '4')
                      const SizedBox(height: CustomSize.sm),
                    if (data.statusService == '4')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('QTY',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    if (data.statusService == '4')
                      TextFormField(
                        controller: controller.qtyRealControllers[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Bagian ini tidak boleh kosong';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                    if (data.statusService == '4')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('** qty <= standart',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.apply(color: Colors.red)),
                      ),
                    if (data.statusService == '4')
                      const SizedBox(height: CustomSize.sm),
                    if (data.statusService == '4')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('KETERANGAN',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    if (data.statusService == '4')
                      TextFormField(
                        controller: controller.keteranganControllers[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Bagian ini tidak boleh kosong';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
