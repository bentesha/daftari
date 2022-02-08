// ignore_for_file: constant_identifier_names
import '../source.dart';

enum Pages {
  sales_page,
  categories_page,
  purchases_page,
  expenses_page,
  stock_adjustment_page
}

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar(
      {Key? key, required this.title, required this.showDrawerCallback})
      : super(key: key);

  final VoidCallback showDrawerCallback;
  final String title;

  static final month = DateFormatter.getCurrentMonth();
  static final year = DateFormatter.getCurrentYear();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 20.dw)),
      ),
      child: AppBar(
        elevation: 0,
        title: const Text('Bella Bella Boutique'),
        leading: AppIconButton(
          icon: Icons.menu,
          onPressed: showDrawerCallback,
        ),
        bottom: PreferredSize(
            child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 19.dw, bottom: 5.dw),
                  child: AppText(
                    '$month, $year $title'.toUpperCase(),
                    color: AppColors.onPrimary,
                    size: 14.dw,
                  ),
                )),
            preferredSize: Size.fromHeight(60.dh)),
      ),
    );
  }

//  static final _appBar = AppBar();

  @override
  Size get preferredSize => Size(double.infinity, 60.dh);
}
