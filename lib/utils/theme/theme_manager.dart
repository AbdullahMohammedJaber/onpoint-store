import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:ecommerce_one/utils/theme/font_manager.dart';
import 'package:ecommerce_one/utils/theme/styles_manager.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.light,
    // main colors
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.greyColor,
    colorScheme: ColorScheme.light(
      primary: ColorManager.primaryColor,
      secondary: ColorManager.primaryColor,
    ),
    primaryColorDark: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    disabledColor: ColorManager.greyColor,
    splashColor: ColorManager.primaryColor,
    fontFamily: FontConstants.fontFamily,

    //  scaffoldBackgroundColor: fWhite,

    // ripple effect color
    iconTheme: IconThemeData(color: ColorManager.primaryColor),

    cardTheme: CardThemeData(
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.greyColor,
      elevation: 4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xfffafafa),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      // color: primary,
      backgroundColor: ColorManager.whiteColor,
      toolbarHeight: 0,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorManager.blackColor),
      // shadowColor: lightPrimary,
      titleTextStyle: getLightStyle(
        fontSize: FontSize.s12,
        color: ColorManager.blackColor,
      ),
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      //disabledColor: borderTextFailed,
      buttonColor: ColorManager.primaryColor,
      splashColor: Colors.red,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: ColorManager.primaryColor,
      inactiveTrackColor: ColorManager.primaryColor,
      trackShape: const RectangularSliderTrackShape(),
      trackHeight: 0.1,
      thumbColor: ColorManager.primaryColor,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
      overlayColor: Colors.red,
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
    ),
    // elevated button them
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.whiteColor,
          fontSize: FontSize.s17,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.whiteColor,
          fontSize: FontSize.s14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: ColorManager.blackColor,
      labelColor: ColorManager.whiteColor,
      unselectedLabelStyle: getLightStyle(
        fontSize: 14,
        color: ColorManager.primaryColor.withValues(alpha: 0.3),
      ),
      labelStyle: getBoldStyle(fontSize: 16, color: ColorManager.whiteColor),

      // indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(color: ColorManager.primaryColor),
    ),
    textTheme: TextTheme(
      displaySmall: getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ).copyWith(decoration: TextDecoration.lineThrough),
      displayLarge: getBoldStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      displayMedium: getMediumStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      titleSmall: getLightVeryStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      bodySmall: getLightStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      bodyMedium: getMediumStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      labelSmall: getSemiBoldStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(color: Colors.red),
    ),

    // label style
  );
}

ThemeData getDarkApplicationTheme() {
  final base = getApplicationTheme();
  const darkBackground = Color(0xff121212);
  const darkSurface = Color(0xff1E1E1E);
  const darkText = Color(0xffF5F5F5);

  return base.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.dark(
      primary: ColorManager.primaryColor,
      secondary: ColorManager.primaryColor,
      surface: darkSurface,
    ),
    cardTheme: base.cardTheme.copyWith(
      color: darkSurface,
      shadowColor: Colors.black,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: darkSurface,
      iconTheme: const IconThemeData(color: darkText),
      titleTextStyle: getLightStyle(fontSize: FontSize.s12, color: darkText),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: darkSurface,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: const Color(0xff252525),
      hintStyle: getRegularStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.greyColor,
        fontSize: FontSize.s14,
      ),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: darkText,
      displayColor: darkText,
    ),
  );
}
