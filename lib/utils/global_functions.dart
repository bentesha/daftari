import 'package:inventory_management/source.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void push(Widget page) async => await navigatorKey.currentState
    ?.push(MaterialPageRoute(builder: (_) => page));

void pop() => navigatorKey.currentState?.pop();

void showSnackBar(String message,
    {BuildContext? context, GlobalKey<ScaffoldState>? scaffoldKey}) {
  if (context != null) _showSnackBarCallback(context, message);
  if (scaffoldKey != null) {
    if (scaffoldKey.currentState == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _showSnackBarCallback(scaffoldKey.currentContext!, message);
      });
    } else {
      _showSnackBarCallback(scaffoldKey.currentContext!, message);
    }
  }
}

String getErrorMessage(var error) {
  log(error.toString());
  if (error is ApiErrors) return error.message;
  return ApiErrors.unknown().message;
}

void _showSnackBarCallback(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      dismissDirection: DismissDirection.none,
      backgroundColor: AppColors.error,
      content: AppText(message, color: AppColors.onError)));
}
