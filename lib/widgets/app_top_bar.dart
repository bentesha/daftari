// ignore_for_file: constant_identifier_names
import '../source.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({Key? key, required this.showDrawerCallback})
      : super(key: key);

  final VoidCallback showDrawerCallback;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(titleTextStyle: TextStyle(fontSize: 18.dw)),
      ),
      child:
          AppBar(elevation: 0, title: const Text('DAFTARI'), centerTitle: true),
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
