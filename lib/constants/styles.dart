import 'package:echo_frame/constants/sizes.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  Styles._();

  static TextStyle title({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeLarge,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle titleBold({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle mediumTitle({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle mediumTitleBold({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle navbarTitle({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle regular({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeRegular,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle regularBold({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeRegular,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle regularItalic({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeRegular,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: textColor,
      );

  static TextStyle subtext({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle subtextBold({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeSmall,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle smallNote({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeExtraSmall,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle smallBoldNote({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeExtraSmall,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle inputRegular({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.inputFontSize,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle inputError({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.inputErrorFontSize,
        fontWeight: FontWeight.w400,
        color: textColor,
      );

  static TextStyle buttonText({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeRegularMedium,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static TextStyle linkText({Color? textColor}) => GoogleFonts.lato(
        fontSize: Sizes.fontSizeRegular,
        fontWeight: FontWeight.w600,
        color: textColor,
      );

  static OutlineInputBorder get noBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(
          Sizes.inputRadius,
        ),
      );

  static OutlineInputBorder get errorBorder => border(
        width: 1.5,
        radius: Sizes.inputRadius,
        color: KnownColors.strawberry600,
      );

  static OutlineInputBorder border({
    double width = 1.5,
    double radius = Sizes.inputRadius,
    required Color color,
  }) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          width: width,
          color: color,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
      );
}
