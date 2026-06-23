import 'package:cherry_toast/cherry_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_one/route/navigation_server.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

void showMessage(String message, {required bool value}) {
  final context = NavigationService.navigatorKey.currentContext;
  if (context == null || message.trim().isEmpty) return;

  final title = Text(
    message.tr(),
    style: TextStyle(color: ColorManager.blackColor),
  );
  if (value) {
    CherryToast.success(title: title).show(context);
  } else {
    CherryToast.error(title: title).show(context);
  }
}
