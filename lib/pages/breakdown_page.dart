import '../source.dart';

class BreakDownPage extends StatelessWidget {
  const BreakDownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: AppText('Breakdown Page',
                size: 18.dw, color: AppColors.onPrimary)));
  }
}
