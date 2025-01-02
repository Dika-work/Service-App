import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/screens/home/controller/home_mekanik_controller.dart';

class HomeMekanikView extends GetView<HomeMekanikController> {
  const HomeMekanikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Home Mekanik'),
          IconButton(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
