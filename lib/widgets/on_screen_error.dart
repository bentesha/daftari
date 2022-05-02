import '../source.dart';

class OnScreenError extends StatelessWidget {
  const OnScreenError(
      {required this.message, required this.tryAgainCallback, Key? key})
      : super(key: key);

  final String message;
  final VoidCallback tryAgainCallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.dh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(message, alignment: TextAlign.center),
            AppTextButton(
                onPressed: tryAgainCallback,
                text: 'Try Again',
                textColor: AppColors.onPrimary,
                backgroundColor: AppColors.primary,
                height: 40.dh,
                margin: EdgeInsets.only(top: 20.dh))
          ],
        ),
      )),
    );
  }
}
