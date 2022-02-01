import '../source.dart';

class AppText extends StatelessWidget {
  const AppText(this.data,
      {this.color, key, this.size, this.weight, this.opacity})
      : super(key: key);

  final String data;
  final Color? color;
  final double? size, opacity;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(data,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontFamily: Constants.kFontFam,
          fontWeight: weight ?? FontWeight.w400,
          fontSize: size ?? 16.dw,
          color: (color ?? AppColors.onBackground).withOpacity(opacity ?? 1),
        ));
  }
}
