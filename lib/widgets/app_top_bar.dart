// ignore_for_file: constant_identifier_names
import '../source.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({Key? key, required this.showDrawerCallback})
      : super(key: key);

  final VoidCallback showDrawerCallback;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: AppText('DAFTARI',
            weight: FontWeight.w500, color: AppColors.onPrimary, size: 20.dw),
        centerTitle: true);
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
