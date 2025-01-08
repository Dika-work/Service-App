import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/custom_size.dart';
import '../loadings/loading.dart';
import '../theme/app_colors.dart';

class CustomDialogs {
  static defaultDialog({
    required BuildContext context,
    Widget? titleWidget,
    required Widget contentWidget,
    String cancelText = 'Batal',
    String? confirmText,
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: titleWidget,
          content: contentWidget,
          actions: <Widget>[
            TextButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text(confirmText ?? 'Oke'),
            ),
          ],
        );
      },
    );
  }

  static deleteDialog({
    required BuildContext context,
    String title = 'Konfirmasi Penghapusan',
    String content =
        'Menghapus data ini akan menghapus semua data yang terkait. Apakah Anda yakin?',
    String cancelText = 'Batal',
    String confirmText = 'Hapus',
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  static loadingIndicator() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      barrierColor: Colors.transparent, // Set barrier color to transparent
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  padding:
                      const EdgeInsets.all(8.0), // Adjust padding if needed
                  decoration: const BoxDecoration(
                    color: AppColors
                        .primary, // Adjust color to match your primary color
                    shape: BoxShape.circle,
                  ),
                  child: const CircularProgressIndicator(
                    color: AppColors.white,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: CustomSize.spaceBtwItems),
              const LoadingText()
            ],
          ),
        );
      },
    );
  }
}
