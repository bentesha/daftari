import '../source.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget(
      {required this.message,
      Key? key,
      this.onPressed,
      this.hasButton = false,
      this.buttonText})
      : super(key: key);

  final String message;
  final VoidCallback? onPressed;
  final bool hasButton;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty,
              size: 45.dw, color: AppColors.onBackground),
          SizedBox(height: 30.dh),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.dw),
            child: AppText(message, alignment: TextAlign.center),
          ),
          hasButton
              ? Builder(builder: (context) {
                  return AppTextButton(
                    onPressed: onPressed ?? () {},
                    height: 40.dh,
                    text: buttonText ?? 'Add Item',
                    margin:
                        EdgeInsets.only(left: 19.dw, right: 19.dw, top: 40.dh),
                  );
                })
              : Container()
        ],
      ),
    );
  }
}
