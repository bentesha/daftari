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
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: AppColors.onSecondary,
                fontSize: 20,
                fontFamily: Constants.kFontFam,
                fontWeight: FontWeight.w500)),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: AppColors.primary, circularTrackColor: AppColors.onPrimary),
        dialogTheme: const DialogTheme(
          backgroundColor: AppColors.onSecondary,
          elevation: 5,
        ),
        iconTheme: const IconThemeData(color: AppColors.onPrimary, size: 30),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          elevation: 2,
        ),
        listTileTheme: const ListTileThemeData(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0));
  }
}
