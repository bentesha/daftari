import '../source.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: 'Settings'), body: _buildBody());
  }

  _buildBody() {
    return ListView(
      children: [
        _buildListTile('Opening Stock'),
      ],
    );
  }

  _buildListTile(String title) {
    return AppMaterialButton(
      onPressed: () {},
      isFilled: false,
      child: ListTile(
        title: Row(
          children: [
            Icon(Icons.inventory_2_outlined,
                color: AppColors.onBackground, size: 22.dw),
            SizedBox(width: 15.dw),
            AppText(title, weight: FontWeight.w500),
          ],
        ),
        trailing: Icon(Icons.chevron_right, size: 22.dw),
        contentPadding: EdgeInsets.symmetric(horizontal: 19.dw),
      ),
    );
  }
}
