import '../source.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: kFontFam,
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
                fontSize: 18,
                fontFamily: kFontFam,
                fontWeight: FontWeight.w500)),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: AppColors.primary, circularTrackColor: AppColors.onPrimary),
        checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith(getCheckBoxColor)),
        dialogTheme: const DialogTheme(
          backgroundColor: AppColors.onSecondary,
          elevation: 5,
        ),
        iconTheme: const IconThemeData(color: AppColors.onPrimary, size: 25),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          elevation: 2,
        ),
        listTileTheme: const ListTileThemeData(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0));
  }

  static Color getCheckBoxColor(Set<MaterialState> state) {
    if (state.contains(MaterialState.selected)) return AppColors.accent;
    return AppColors.onBackground2;
  }
}
