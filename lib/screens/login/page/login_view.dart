import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/constant/custom_size.dart';
import 'package:service/screens/login/controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Image.asset(
                'assets/images/lps.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(height: CustomSize.spaceBtwSections),
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: CustomSize.md),
                      child: TextFormField(
                        controller: controller.usernameC,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: CustomSize.spaceBtwInputFields),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: CustomSize.md),
                        child: Obx(
                          () => TextFormField(
                            controller: controller.passC,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.obscureText.value =
                                      !(controller.obscureText.value);
                                },
                                icon: Icon(
                                  (controller.obscureText.value != false)
                                      ? Icons.lock
                                      : Icons.lock_open,
                                ),
                              ),
                            ),
                            obscureText: controller.obscureText.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          CustomSize.md, CustomSize.md, CustomSize.md, 0),
                      child: Row(
                        children: [
                          Obx(
                            () => SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: (value) => controller.rememberMe
                                    .value = !controller.rememberMe.value,
                              ),
                            ),
                          ),
                          const Text(
                            'Ingat Saya',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CustomSize.spaceBtwSections),
              Obx(
                () => controller.isLoading.isTrue
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: CustomSize.md),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => controller.loginEmailandPassword(),
                            child: const Text('Login'),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
