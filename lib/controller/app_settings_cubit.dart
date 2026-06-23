import 'package:ecommerce_one/controller/app_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(const AppSettingsState());

  void toggleTheme(bool isDark) {
    emit(state.copyWith(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

  void toggleLanguage() {
    emit(
      state.copyWith(
        locale: state.isArabic ? const Locale('en') : const Locale('ar'),
      ),
    );
  }

  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
