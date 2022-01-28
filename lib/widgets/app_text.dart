import '../source.dart';

class AppText extends StatelessWidget {
  const AppText(this.data,
      {this.style, this.color = AppColors.onBackground, key})
      : super(key: key);

  final String data;
  final TextStyle? style;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(data,
        textAlign: TextAlign.start, style: style ?? AppTextStyles.body);
  }
}
