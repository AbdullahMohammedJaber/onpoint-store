// ignore_for_file: deprecated_member_use

import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_title_bar.dart';
import 'package:ecommerce_one/controller/app_settings_cubit.dart';
import 'package:ecommerce_one/controller/app_settings_state.dart';
import 'package:ecommerce_one/screen/setting/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  final bool showBackButton;

  const SettingScreen({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(
        title: context.tr('settings'),
        canBack: showBackButton,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<AppSettingsCubit, AppSettingsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
             
                      secondary: const Icon(Icons.dark_mode_outlined),
                      title: Text(context.tr('dark_mode')),
                      value: state.isDarkMode,
                      onChanged:
                          (value) => context
                              .read<AppSettingsCubit>()
                              .toggleTheme(value),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                       
                      leading: const Icon(Icons.language_outlined),
                      title: Text(context.tr('language')),
                      subtitle: Text(
                        context.locale.languageCode == 'ar'
                            ? context.tr('arabic')
                            : context.tr('english'),
                      ),
                      trailing: const Icon(Icons.swap_horiz),
                      onTap: () {
                        final nextLocale =
                            context.locale.languageCode == 'ar'
                                ? AppLocales.en
                                : AppLocales.ar;
                        context.setLocale(nextLocale);
                        context.read<AppSettingsCubit>().setLocale(nextLocale);
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            buildInfoCard(
              context: context,
              icon: Icons.privacy_tip_outlined,
              title: context.tr('privacy_policy'),
              onTap: () {},
            ),
            const SizedBox(height: 12),

            buildInfoCard(
              context: context,
              icon: Icons.assignment_return_outlined,
              title: context.tr('return_policy'),
              onTap: () {},
            ),
            const SizedBox(height: 12),

            buildInfoCard(
              context: context,
              icon: Icons.info_outline,
              title: context.tr('about_us'),
              onTap: () {},
            ),
            const SizedBox(height: 12),

            buildInfoCard(
              context: context,
              icon: Icons.contact_support_outlined,
              title: context.tr('contact_us'),
              onTap: () {},
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
