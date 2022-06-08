import '../source.dart';
import '../utils/extensions.dart/write_off_type.dart';

class TypeSelector<T> extends StatefulWidget {
  const TypeSelector(
      {Key? key,
      required this.onTypeSelected,
      required this.selectedType,
      required this.title,
      required this.error,
      required this.isEditable})
      : super(key: key);

  final ValueChanged<T> onTypeSelected;
  final T? selectedType;
  final String title;
  final String? error;
  final bool isEditable;

  @override
  State<TypeSelector<T>> createState() => _TypeSelectorState<T>();
}

class _TypeSelectorState<T> extends State<TypeSelector<T>> {
  late List<T> options;

  @override
  void initState() {
    options = _getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedType = _getType(widget.selectedType);
    return AppTextButton(
      backgroundColor: AppColors.surface,
      onPressed: widget.isEditable ? () => _showOptionsDialog(context) : () {},
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: Column(
        children: [
          ListTile(
            title: AppText(widget.title.toUpperCase(), opacity: .7),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.dh),
              child: AppText(selectedType ?? 'Tap to select',
                  weight: FontWeight.w500),
            ),
            trailing: widget.isEditable
                ? const Icon(Icons.chevron_right)
                : Container(width: .1),
          ),
          _buildError()
        ],
      ),
    );
  }

  _showOptionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: SizedBox(
              height: T == WriteOffTypes ? 205.dh : 123.dh,
              child: Column(
                children: [_buildTitle(), _buildOptions()],
              ),
            ),
          );
        });
  }

  _buildTitle() {
    return Container(
      height: 40.dh,
      width: double.infinity,
      alignment: Alignment.center,
      color: AppColors.primary,
      child: AppText(
          T == WriteOffTypes ? 'CHOOSE WRITE-OFF TYPE' : 'CHOOSE CATEGORY TYPE',
          color: AppColors.onPrimary),
    );
  }

  _buildOptions() {
    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (_, index) => _buildOption(options[index]),
      itemCount: options.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  _buildOption(var type) {
    final typeString = _getType(type);
    return AppTextButton(
        onPressed: () {
          pop();
          widget.onTypeSelected(type);
        },
        isFilled: false,
        child: Container(
          height: 40.dh,
          alignment: Alignment.center,
          child: AppText(typeString!),
          width: double.infinity,
        ));
  }

  _buildError() {
    final hasError = widget.error != null;
    if (hasError) {
      return Padding(
        padding: EdgeInsets.only(top: 10.dh),
        child: AppText(widget.error!),
      );
    }
    return Container();
  }

  List<T> _getOptions() {
    late List list;
    if (T == WriteOffTypes) {
      list = [
        WriteOffTypes.stolen,
        WriteOffTypes.damaged,
        WriteOffTypes.expired,
        WriteOffTypes.other
      ];
    } else {
      list = [CategoryTypes.products, CategoryTypes.expenses];
    }
    return list.whereType<T>().toList();
  }

  String? _getType(dynamic type) {
    if (type == null) return null;
    if (T == WriteOffTypes) {
      return (type as WriteOffTypes).string;
    } else {
      return (type as CategoryTypes).string;
    }
  }
}
