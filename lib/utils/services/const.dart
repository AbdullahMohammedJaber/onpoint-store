import 'package:cherry_toast/cherry_toast.dart';
import 'package:ecommerce_one/route/navigation_server.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

double hi = 0.0;
double wi = 0.0;

showMessage(String message, {required bool value}) {
  if (value) {
    CherryToast.success(
      title: Text(message, style: TextStyle(color: ColorManager.blackColor)),
    ).show(NavigationService.navigatorKey.currentContext!);
  } else {
    CherryToast.error(
      title: Text(message, style: TextStyle(color: ColorManager.blackColor)),
    ).show(NavigationService.navigatorKey.currentContext!);
  }
}
