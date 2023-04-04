import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/font_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getLightTheme() => ThemeData(
      primaryColor: AppLightColors.primaryLightColor,
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: AppLightColors.primaryLightColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppLightColors.primaryLightColor,
        shape: const StadiumBorder(),
        foregroundColor: AppLightColors.floatingIconColor,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.inconsolata(
          color: AppLightColors.primaryLightColor,
          fontSize: FontSizes.appbarTitleFontSize,
          fontWeight: FontWeight.w500,
        ),
        elevation: AppValues.appbarElevation,
        backgroundColor: AppLightColors.transparent,
        iconTheme: const IconThemeData(
          color: AppLightColors.appBarIconLightColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(AppLightColors.primaryLightColor),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppSizes.spaceSize10,
                ),
              ),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.inconsolata(
              color: AppLightColors.buttonTextColor,
              fontSize: FontSizes.buttonFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: AppLightColors.primaryLightColor,
        prefixIconColor: AppLightColors.primaryLightColor,
        labelStyle: GoogleFonts.inconsolata(
          color: AppLightColors.accentColor,
          fontSize: FontSizes.textFieldLabelFontSize,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: GoogleFonts.inconsolata(
          color: AppLightColors.errorColor,
          fontSize: FontSizes.textFieldLabelFontSize,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: BorderSizes.b1,
            color: AppLightColors.accentColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: BorderSizes.b1,
            color: AppLightColors.primaryLightColor,
          ),
        ),
        outlineBorder: BorderSide(
          width: BorderSizes.b1,
          color: AppLightColors.primaryLightColor,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: BorderSizes.b1,
            color: AppLightColors.errorColor,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            AppLightColors.primaryLightColor,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            GoogleFonts.inconsolata(
              color: AppLightColors.primaryLightColor,
              fontSize: FontSizes.buttonFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      tabBarTheme: const TabBarTheme(
        indicatorColor: AppLightColors.tabBarIndicatorColor,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.all(AppPaddings.p5),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inconsolata(
          color: AppLightColors.primaryLightColor,
          fontSize: FontSizes.bigTitleFontSize,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: GoogleFonts.inconsolata(
          color: AppLightColors.primaryLightColor,
          fontSize: FontSizes.longFontSize,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: GoogleFonts.inconsolata(
          color: AppLightColors.accentColor,
          fontSize: FontSizes.descriptionFontSize,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.inconsolata(
          color: AppLightColors.primaryLightColor,
          fontSize: FontSizes.bodySmallFontSize,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.inconsolata(
          color: AppLightColors.buttonTextColor,
          fontSize: FontSizes.containerBodyFontSize,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),

//For TextField Text Style
        labelSmall: GoogleFonts.inconsolata(
          color: AppLightColors.labelSmallColor,
          fontSize: FontSizes.labelSmallFontSize,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: GoogleFonts.inconsolata(
          color: AppLightColors.accentColor,
          fontSize: FontSizes.textFieldTextFontSize,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: GoogleFonts.inconsolata(
          color: AppLightColors.primaryLightColor,
          fontSize: FontSizes.textFieldTextFontSize,
          fontWeight: FontWeight.w600,
        ),

        headlineMedium: GoogleFonts.inconsolata(
          color: AppLightColors.errorDialogTextColor,
          fontSize: FontSizes.errorDialogTextFontSize,
          fontWeight: FontWeight.w500,
        ),

        headlineSmall: GoogleFonts.inconsolata(
          color: AppLightColors.popUpRowColor,
          fontSize: FontSizes.popUpTitleFontSize,
          fontWeight: FontWeight.w500,
        ),

        //Splash Text
        headlineLarge: GoogleFonts.inconsolata(
          color: AppLightColors.splashTitleColor,
          fontSize: FontSizes.splashFontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
