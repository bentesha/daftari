import '../source.dart';

class AppTheme {
  ///To my surprise this information gets references to even before the app has
  ///built a single widget. So I decided to shift the appBarThemeData from here
  ///to where the appBar starts built. It is where I supplied another Theme widget.
  ///So finding a close instance of the Theme widgets by the context of the
  ///appBar, it will be found in that Theme class.
  ///
  static ThemeData themeData() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: Constants.kFontFam,
      primaryColor: AppColors.primary,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary,
        selectionHandleColor: AppColors.primary,
      ),
    );
  }
}
