import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:service/screens/home/controller/home_staff_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/custom_size.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widget/expandable_container.dart';

class HomeStaffView extends GetView<HomeStaffController> {
  const HomeStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: CustomSize.imageCarouselHeight,
                    padding: const EdgeInsets.only(top: CustomSize.lg),
                    decoration: const BoxDecoration(
                      color: AppColors.light,
                      image: DecorationImage(
                          image: AssetImage('assets/images/ship.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned.fill(
                      child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.username.value.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                CustomSize.sm, 0, CustomSize.sm, CustomSize.sm),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[500]!,
                                  highlightColor: Colors.white,
                                  child: Text(
                                    'Langgeng Pranamas Sentosa',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () =>
                                          Scaffold.of(context).closeDrawer(),
                                      child: const Icon(
                                        Iconsax.back_square,
                                        size: CustomSize.iconMd,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              ExpandableContainer(
                icon: Iconsax.user,
                textTitle: 'Master Kategori Sevice',
                content: Column(
                  children: [
                    ListTile(
                      onTap: () => Get.toNamed(Routes.MASTER_PART),
                      leading: const Icon(
                        Iconsax.record,
                        color: AppColors.black,
                      ),
                      title: Text(
                        'Kategori Service',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.black),
                      ),
                    ),
                    ListTile(
                      onTap: () => Get.toNamed(Routes.DETAIL_KATEGORI),
                      leading: const Icon(
                        Iconsax.record,
                        color: AppColors.black,
                      ),
                      title: Text(
                        'Detail Kategori Service',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.black),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text('Home Staff'),
      ),
    );
  }
}
