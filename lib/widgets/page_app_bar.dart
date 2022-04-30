import '../source.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar(
      {Key? key, required this.title, this.actionIcons, this.actionCallbacks})
      : super(key: key);

  final String title;
  final List<VoidCallback?>? actionCallbacks;
  final List<IconData?>? actionIcons;

  factory PageAppBar.onDocumentPage(
      {required String title,
      required PageActions action,
      required VoidCallback updateActionCallback,
      required VoidCallback deleteDocumentCallback,
      required VoidCallback saveDocumentCallback,
      required VoidCallback editDocumentCallback}) {
    return PageAppBar(
        title: title,
        actionIcons: action.isViewing
            ? [Icons.edit_outlined, Icons.delete_outlined]
            : [Icons.done],
        actionCallbacks: action.isViewing
            ? [updateActionCallback, deleteDocumentCallback]
            : [action.isEditing ? editDocumentCallback : saveDocumentCallback]);
  }

  factory PageAppBar.onModelPage(
      {required String title,
      required PageActions action,
      required bool wasViewingDocument,
      required VoidCallback updateActionCallback,
      required VoidCallback deleteModelCallback,
      required VoidCallback saveModelCallback,
      required VoidCallback editModelCallback}) {
    return PageAppBar(
        title: title,
        actionIcons: wasViewingDocument
            ? []
            : action.isViewing
                ? [Icons.edit_outlined, Icons.delete_outlined]
                : [Icons.check],
        actionCallbacks: wasViewingDocument
            ? []
            : action.isViewing
                ? [updateActionCallback, deleteModelCallback]
                : [action.isEditing ? editModelCallback : saveModelCallback]);
  }

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
        iconThemeData: IconThemeData(size: 20.dw),
        margin: EdgeInsets.only(right: 19.dw));
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
