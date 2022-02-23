import '../source.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar(
      {Key? key, required this.title, this.actionIcons, this.actionCallbacks})
      : super(key: key);

  final String title;
  final List<VoidCallback?>? actionCallbacks;
  final List<IconData?>? actionIcons;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(title,
          size: 22.dw, style: Theme.of(context).appBarTheme.titleTextStyle!),
      actions: _buildActions(),
    );
  }

  List<Widget>? _buildActions() {
    if (actionCallbacks == null) return null;

    return actionCallbacks!.map((e) {
      final index = actionCallbacks!.indexOf(e);
      return _buildAction(actionIcons?[index], e);
    }).toList();
  }

  Widget _buildAction(IconData? icon, VoidCallback? callback) {
    return AppIconButton(
        onPressed: callback ?? () {},
        icon: icon ?? Icons.done,
        margin: EdgeInsets.only(right: 19.dw));
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
