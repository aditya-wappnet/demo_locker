// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:demo_locker_app/constant/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// primary color
const COLOR_PRIMARY = Color(0xff83B549);
Color COLOR_PRIMARY_DARK = const Color(0xff121111);
Color COLOR_PRIMARY_LIGHT = const Color(0xff848285);
const COLOR_BORDER = Color(0xff8DD99F);
const COLOR_STATUS = Color(0xff138D2E);

//secondary color
const COLOR_BACKGROUND = Color(0xffFFFFFF);
Color COLOR_CARD_BACKGROUD = const Color(0xff83B549).withOpacity(0.2);
const COLOR_RED = Color(0xffFE3232);

// Font Family
const fontSemiBold = 'Poppins-SemiBold';
const fontMedium = 'Poppins-Medium';
const fontRegular = 'Poppins-Regular';

enum AppTheme {
  CustomTheme,
  LightTheme,
  DarkTheme,
}

final appThemeData = {
  AppTheme.CustomTheme: ThemeData.light().copyWith(
    primaryColor: COLOR_PRIMARY,
    primaryColorLight: COLOR_PRIMARY_LIGHT,
    primaryColorDark: COLOR_PRIMARY_DARK,
    secondaryHeaderColor: COLOR_PRIMARY.withOpacity(0.7),
    scaffoldBackgroundColor: COLOR_BACKGROUND,
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: COLOR_PRIMARY_LIGHT,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      labelColor: COLOR_PRIMARY,
      labelStyle: textBodyStyle.copyWith(color: COLOR_PRIMARY),
      unselectedLabelStyle: textBodyStyle.copyWith(color: COLOR_PRIMARY_LIGHT),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: COLOR_BACKGROUND,
      foregroundColor: COLOR_BACKGROUND,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: COLOR_BACKGROUND,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: smallTitleTextStyle,
      iconTheme: IconThemeData(color: COLOR_PRIMARY_DARK),
      actionsIconTheme: IconThemeData(color: COLOR_PRIMARY_DARK),
    ),
    iconTheme: IconThemeData(color: COLOR_PRIMARY_DARK),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryTextTheme:
        TextTheme(titleSmall: TextStyle(color: COLOR_PRIMARY_DARK)),
    colorScheme: ColorScheme.light(
        primary: COLOR_PRIMARY,
        onPrimary: COLOR_BACKGROUND,
        onSurface: COLOR_PRIMARY_DARK),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: COLOR_PRIMARY,
      ),
    ),
  ),
  AppTheme.LightTheme: ThemeData(
    brightness: Brightness.light,
  ),
  //Dark Theme
  AppTheme.DarkTheme: ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black.withOpacity(0.1),
      elevation: 0,
      foregroundColor: Colors.black.withOpacity(0.1),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black.withOpacity(0.1),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: COLOR_PRIMARY),
      actionsIconTheme: const IconThemeData(color: COLOR_PRIMARY),
      titleTextStyle: smallTitleTextStyle.copyWith(color: COLOR_PRIMARY),
    ),
    primaryColor: COLOR_PRIMARY,
    primaryColorLight: COLOR_BACKGROUND,
    primaryColorDark: const Color(0xff83B549),
    secondaryHeaderColor: COLOR_PRIMARY.withOpacity(0.7),
    scaffoldBackgroundColor: Colors.black.withOpacity(0.1),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: COLOR_PRIMARY_LIGHT,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(0.1),
      ),
      labelColor: COLOR_PRIMARY,
      labelStyle: textBodyStyle.copyWith(color: COLOR_PRIMARY),
      unselectedLabelStyle: textBodyStyle.copyWith(color: COLOR_PRIMARY_LIGHT),
    ),
    iconTheme: const IconThemeData(color: COLOR_PRIMARY),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      titleSmall: TextStyle(color: COLOR_PRIMARY),
    ),
    primaryTextTheme: const TextTheme(
      titleSmall: TextStyle(color: COLOR_PRIMARY),
    ),
    colorScheme: ColorScheme.light(
        primary: COLOR_PRIMARY,
        onPrimary: COLOR_BACKGROUND,
        onSurface: COLOR_PRIMARY_DARK),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: COLOR_PRIMARY,
      ),
    ),
  ),
};
