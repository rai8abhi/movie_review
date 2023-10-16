import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/app_constants.dart';
import '../helper/colors.dart';
import '../helper/responsive_ui.dart';
import '../widgets/custom_text.dart';

class AppDialogs {
  static Future<void> showDialogActionError(
    BuildContext? context,
    String title,
    String message,
    String buttonTitle,
    bool barrierDismissible,
    Function onAccepted,
  ) async {
    await closeSnack();
    Get.snackbar(
      title,
      message,
      titleText: CustomText(
        text: title,
        color: AppColors.primaryColor,
        fontSize: ResponsiveUI().fontSize(4.1),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        maxLines: 2,
      ),
      messageText: CustomText(
        text: message,
        color: AppColors.primaryColor,
        fontSize: ResponsiveUI().fontSize(4),
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        maxLines: 3,
      ),
      isDismissible: barrierDismissible,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: AppConstants.DEFAULT_TOAST_DURATION),
      backgroundColor: AppColors.errorBackground.withOpacity(0.5),
      colorText: AppColors.primaryColor,
      borderColor: AppColors.errorBackground.withOpacity(0.8),
      borderRadius: ResponsiveUI().height(1),
      borderWidth: 1,
      barBlur: 5,
      padding: EdgeInsets.only(
        top: ResponsiveUI().height(2),
        bottom: ResponsiveUI().height(2),
        left: ResponsiveUI().height(2),
        right: ResponsiveUI().height(2),
      ),
      margin: EdgeInsets.only(
        top: ResponsiveUI().height(1),
        left: ResponsiveUI().height(1),
        right: ResponsiveUI().height(1),
      ),
      icon: Icon(
        Icons.error_rounded,
        color: AppColors.primaryColor,
        size: ResponsiveUI().height(4), // 35
      ),
      snackbarStatus: (status) async {
        // handle snack bar status
        if (status == SnackbarStatus.CLOSED) {}
      },
    );
  }

  static closeSnack() async {
    if (Get.isSnackbarOpen != null && Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
  }
}
