part of 'constants.dart';

class Styles {
  Styles._();

  static OutlineInputBorder get noBorder => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(Sizes.inputBorderRadius),
      );

  static OutlineInputBorder border({
    double? width,
    double? radius,
    Color? color,
  }) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          width: width ?? Sizes.inputBorderWidth,
          color: color ?? KnownColors.slate500,
        ),
        borderRadius: BorderRadius.circular(radius ?? Sizes.inputBorderRadius),
      );

  static OutlineInputBorder focusedBorder({Color? color}) => border(
        width: Sizes.inputBorderFocusedWidth,
        color: color ?? KnownColors.sky500,
      );

  static OutlineInputBorder errorBorder({Color? color}) => border(
        width: Sizes.inputBorderFocusedWidth,
        color: color ?? KnownColors.strawberry500,
      );

  static TextStyle title({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle subtitle({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle body({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeRegular,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodyBold({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeRegular,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle caption({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle captionBold({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeSmall,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle micro({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeExtraSmall,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle button({Color? color}) => GoogleFonts.roboto(
        fontSize: Sizes.fontSizeSmall,
        fontWeight: FontWeight.w700,
        color: color ?? KnownColors.basicWhite,
      );

// static BoxShadow get cardShadow => BoxShadow(
//   color: KnownColors.basicBlack.withValues(alpha: 0.08),
//   offset: const Offset(0, 2),
//   blurRadius: 8,
//   spreadRadius: 0,
// );
//
// static BoxShadow get elevatedShadow => BoxShadow(
//   color: KnownColors.basicBlack.withValues(alpha: 0.15),
//   offset: const Offset(0, 4),
//   blurRadius: 16,
//   spreadRadius: 0,
// );
}
