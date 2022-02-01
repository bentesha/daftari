import '../source.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet(
      {Key? key, required this.titles, required this.callbacks})
      : super(key: key);

  final List<String> titles;
  final List<VoidCallback?> callbacks;

  @override
  Widget build(BuildContext context) {
    final lastIndex = titles.length - 1;

    return Container(
      color: AppColors.secondary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetOpeningTile(),
          ListView.builder(
            itemCount: titles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return _buildTextButton(titles[index],
                  onPressed: callbacks[index],
                  textColor: index == lastIndex
                      ? AppColors.accent
                      : AppColors.onSecondary);
            },
          )
        ],
      ),
    );
  }

  _buildTextButton(String text,
      {required Color textColor, VoidCallback? onPressed}) {
    return Builder(builder: (context) {
      return AppTextButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        height: 40.dh,
        padding: EdgeInsets.only(left: 19.dw),
        text: text,
        alignment: Alignment.centerLeft,
        isFilled: false,
        textStyle: AppTextStyles.body2.copyWith(color: textColor),
      );
    });
  }
}
