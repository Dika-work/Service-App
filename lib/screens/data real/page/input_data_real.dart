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
          'INPUT DATA REAL',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
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
                            child: TextFormField(
                          controller: TextEditingController(
                              text: getStatusDescription(data.statusService)),
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text('STATUS',
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
                            controller: controller.kmRealC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('KM',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                        const SizedBox(width: CustomSize.sm),
                        Expanded(
                          child: TextFormField(
                            controller: controller.waktuBulanRealC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('WAKTU (BULAN)',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: CustomSize.sm),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.kondisiFisikRealC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('FISIK (CIRI KHUSUS)',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                        const SizedBox(width: CustomSize.sm),
                        Expanded(
                          child: TextFormField(
                            controller: controller.qtyRealC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Bagian ini tidak boleh kosong';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              label: Text('QTY',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: CustomSize.sm),
                    TextFormField(
                      controller: controller.keteranganC,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* Bagian ini tidak boleh kosong';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text('KETERANGAN',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
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
