import '../source.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key, this.height, this.margin, this.color})
      : super(key: key);

  final double? height;
  final EdgeInsets? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      margin: margin ?? EdgeInsets.symmetric(vertical: 5.dh),
      color: color ?? AppColors.divider,
    );
  }
}
