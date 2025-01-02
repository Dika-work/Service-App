import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/custom_size.dart';
import '../../../utils/theme/app_colors.dart';
import '../model/user_model.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key, required this.model});

  final UserModel model;

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController username;
  late String typeUser;
  late TextEditingController password;

  final List<String> typeUserOptions = [
    'super admin',
    'kpool',
    'mekanik',
    'staff',
  ];

  @override
  void initState() {
    super.initState();
    username = TextEditingController(text: widget.model.username);
    typeUser = widget.model.typeUser;
    password = TextEditingController(text: 'test');
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Edit user',
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
                  borderRadius:
                      BorderRadius.circular(CustomSize.borderRadiusSm),
                  color: AppColors.buttonPrimary,
                ),
                child: Text(
                  'BERIKUTNYA',
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
          margin: const EdgeInsets.only(top: 10.0),
          color: Colors.white,
          child: ListView(
            children: [
              const SizedBox(height: CustomSize.xs),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: password,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 10,
                  minLines: 1,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      password.text = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
