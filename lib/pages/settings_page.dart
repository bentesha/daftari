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
        appBar: PageAppBar(
          title: 'Settings',
          actionCallback: () {},
          hasAction: false,
        ),
        body: _buildBody());
  }

  _buildBody() {
    return Column(
      children: [
        AppTextButton(
            text: 'Add Item',
            margin: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
            height: 40.dh,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const ItemEditPage())))
      ],
    );
  }
}
