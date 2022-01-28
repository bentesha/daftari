import '../source.dart';
import 'dart:ui' as ui show Shadow, FontFeature, TextLeadingDistribution;

class AppTextStyles extends TextStyle {
  static TextStyle get heading {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: Constants.kFontFam2,
      fontSize: 20.dw,
      color: AppColors.onBackground,
    );
  }

  static TextStyle get heading2 {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 30.dw,
      color: AppColors.onBackground,
    );
  }

  static TextStyle get body {
    return TextStyle(
        fontSize: 16.dw,
        fontFamily: Constants.kFontFam2,
        color: AppColors.onBackground.withOpacity(.7),
        fontWeight: FontWeight.w500);
  }

  static TextStyle get body2 {
    return TextStyle(
        fontSize: 16.dw,
        color: AppColors.onSecondary,
        fontWeight: FontWeight.w500);
  }

  static TextStyle get subtitle {
    return TextStyle(
        fontSize: 15.dw,
        color: AppColors.onBackground.withOpacity(.65),
        fontWeight: FontWeight.w400);
  }

  ///so that to maintain the consistent text styles across the app, it is overriden
  ///to only change the text color when the text is on different background colors.
  @override
  TextStyle copyWith(
          {bool? inherit,
          Color? color,
          Color? backgroundColor,
          double? fontSize,
          FontWeight? fontWeight,
          FontStyle? fontStyle,
          double? letterSpacing,
          double? wordSpacing,
          TextBaseline? textBaseline,
          double? height,
          ui.TextLeadingDistribution? leadingDistribution,
          Locale? locale,
          Paint? foreground,
          Paint? background,
          List<ui.Shadow>? shadows,
          List<ui.FontFeature>? fontFeatures,
          TextDecoration? decoration,
          Color? decorationColor,
          TextDecorationStyle? decorationStyle,
          double? decorationThickness,
          String? debugLabel,
          String? fontFamily,
          List<String>? fontFamilyFallback,
          String? package,
          TextOverflow? overflow}) =>
      TextStyle(color: color);
}
