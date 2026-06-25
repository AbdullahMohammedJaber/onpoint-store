import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_title_bar.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';

class StaticInfoScreen extends StatelessWidget {
  final String titleKey;
  final String bodyKey;

  const StaticInfoScreen({
    super.key,
    required this.titleKey,
    required this.bodyKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(title: context.tr(titleKey)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorManager.borderBlue),
          ),
          child: DefaultText(
            context.tr(bodyKey),
            fontSize: 15,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.clip,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}
