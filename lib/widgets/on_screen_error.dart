import '../source.dart';

class OnScreenError extends StatelessWidget {
  const OnScreenError(
      {required this.message, required this.tryAgainCallback, Key? key})
      : super(key: key);

  final String message;
  final VoidCallback tryAgainCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(message),
        AppTextButton(
            onPressed: tryAgainCallback,
            text: 'Try Again',
            textColor: AppColors.onPrimary,
            backgroundColor: AppColors.primary,
            height: 40.dh,
            margin: EdgeInsets.only(top: 20.dh, right: 15.dw, left: 15.dw))
      ],
    ));
  }
}
