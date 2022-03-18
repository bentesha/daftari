import '../source.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key, this.height, this.margin, this.color, this.width})
      : super(key: key);

  AppDivider.onDocumentPage({Key? key})
      : height = null,
        width = null,
        margin = EdgeInsets.zero,
        color = AppColors.divider.withOpacity(.35),
        super(key: key);

  final double? height, width;
  final EdgeInsets? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      width: width,
      margin: margin ?? EdgeInsets.symmetric(vertical: 5.dh),
      color: color ?? AppColors.divider,
    );
  }
}
