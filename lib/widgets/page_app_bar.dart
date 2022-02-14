import '../source.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar(
      {Key? key,
      required this.title,
      this.actionIcon,
      this.actionCallback,
      this.hasAction = true})
      : super(key: key);

  final String title;
  final IconData? actionIcon;
  final VoidCallback? actionCallback;
  final bool hasAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(title,
          size: 22.dw, style: Theme.of(context).appBarTheme.titleTextStyle!),
      actions: [
        hasAction
            ? AppIconButton(
                onPressed: actionCallback ?? () {},
                icon: actionIcon ?? Icons.done,
                margin: EdgeInsets.only(right: 19.dw))
            : Container()
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50.dh);
}
