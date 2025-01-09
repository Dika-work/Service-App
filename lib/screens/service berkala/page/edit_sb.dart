import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../../data real/controller/data_real_controller.dart';

class EditDetailSB extends StatefulWidget {
  const EditDetailSB({super.key, required this.idMtc});

  final String idMtc;

  @override
  State<EditDetailSB> createState() => _EditDetailSBState();
}

class _EditDetailSBState extends State<EditDetailSB> {
  late DataRealController controller;
  late String statusSerive;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DataRealController());

    controller.getData(widget.idMtc);
    statusSerive = '';
  }

  final Map<String, String> statusSeriveMap = {
    '1': 'CEK',
    '2': 'REPAIR',
    '3': 'GANTI',
  };

  String getStatusDescription(String? status) {
    switch (status) {
      case '0':
        return 'Status Tidak Jelas';
      case '1':
        return 'CEK';
      case '2':
        return 'REPAIR';
      case '3':
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
          'Edit Status Service Berkala',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.updateTransaksiDetailSb(widget.idMtc),
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
                'UBAH DATA',
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
            itemBuilder: (_, index) {
              final data = controller.realModel[index];
              statusSerive = data.statusService;
              return Container(
                margin: const EdgeInsets.fromLTRB(
                    CustomSize.sm, CustomSize.sm, CustomSize.sm, CustomSize.xs),
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomSize.sm, vertical: CustomSize.md),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: TextEditingController(
                              text: data.deskripsiPengecekan.toUpperCase()),
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text('Deskripsi Pengecekan',
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        )),
                        const SizedBox(width: CustomSize.sm),
                        Expanded(
                            child: TextFormField(
                          controller:
                              TextEditingController(text: data.kmTarget),
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text('KM STANDART',
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: CustomSize.sm),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller:
                              TextEditingController(text: data.bulanTarget),
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text('TARGET (BULAN)',
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        )),
                        const SizedBox(width: CustomSize.sm),
                        Expanded(
                            child: TextFormField(
                          controller:
                              TextEditingController(text: data.tahunTarget),
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text('Target (TAHUN)',
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: CustomSize.sm),
                    TextFormField(
                      controller: TextEditingController(
                          text: data.kondisiFisik.toUpperCase()),
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      maxLines: 10,
                      minLines: 1,
                      decoration: InputDecoration(
                        label: Text('FISIK (CIRI KHUSUS)',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ),
                    const SizedBox(height: CustomSize.sm),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: TextEditingController(
                              text: data.quantity.toUpperCase()),
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text('QTY DI KENDARAAN',
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        )),
                        const SizedBox(width: CustomSize.sm),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(
                              left: CustomSize.sm, right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                CustomSize.inputFieldRadius),
                            border: Border.all(
                                width: 1, color: AppColors.borderPrimary),
                          ),
                          child: DropdownButton<String>(
                            value: statusSerive,
                            underline: const SizedBox.shrink(),
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                statusSerive = newValue!;
                                controller.realModel[index].statusService =
                                    newValue;
                                print('Selected statusSerive: $statusSerive');
                              });
                            },
                            items: statusSeriveMap.entries
                                .map(
                                  (entry) => DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  ),
                                )
                                .toList(),
                          ),
                        ))
                        // Expanded(
                        //     child: TextFormField(
                        //   controller: TextEditingController(
                        //       text: getStatusDescription(data.statusService)),
                        //   keyboardType: TextInputType.none,
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     label: Text('STATUS',
                        //         style: Theme.of(context).textTheme.labelMedium),
                        //   ),
                        // )),
                      ],
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
