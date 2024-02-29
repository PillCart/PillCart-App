import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/helper/constant.dart';
import 'package:pill_cart/widgets/custom_progress_indicator.dart';

/// A utility class for showing and hiding a custom loading dialog.
///
/// This class provides static methods to display a loading dialog with a custom
/// circular progress indicator and to hide the dialog.
class Loader {
  /// Displays a custom loading dialog.
  ///
  /// This method uses the GetX package to show a dialog with a custom circular
  /// progress indicator. The dialog is non-dismissible and has a transparent
  /// background with a semi-transparent barrier color.
  static void showLoading() {
    Get.dialog(
      barrierColor: kBrand100.withOpacity(0.5),
      barrierDismissible: false,
      const Dialog(
        elevation: 0,
        shadowColor: null,
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  /// Hides the custom loading dialog if it is currently displayed.
  ///
  /// This method checks if a dialog is open and closes it if it is.
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
