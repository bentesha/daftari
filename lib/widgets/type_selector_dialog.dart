import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/extensions.dart/write_off_type.dart';

enum Types { reports, writeOffs }

class TypeSelectorDialog<T> extends Dialog {
  const TypeSelectorDialog(
      {required this.onSelected,
      required this.currentType,
      required this.title,
      Key? key})
      : super(key: key);

  final ValueChanged<T> onSelected;
  final T currentType;
  final String title;

  @override
  Widget? get child {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.dh),
        Center(
          child: AppText(title, size: 18.dw, weight: FontWeight.bold),
        ),
        AppDivider(margin: EdgeInsets.only(top: 15.dh)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 10.dh),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  (T == ReportType ? ReportType.values : WriteOffTypes.values)
                      .map((item) => _buildItem(item))
                      .toList()),
        ),
      ],
    );
  }

  Widget _buildItem(var item) {
    final isSelected = item == currentType;
    return AppTextButton(
      text: item is ReportType
          ? item.string
          : item is WriteOffTypes
              ? item.string
              : '',
      onPressed: () {
        pop();
        onSelected(item);
      },
      textStyle: TextStyle(
          color: isSelected ? AppColors.onPrimary : AppColors.onBackground2,
          fontSize: 14.dw),
      backgroundColor: isSelected ? AppColors.primary : AppColors.background,
      borderRadius: BorderRadius.circular(20.dw),
      height: 40.dh,
    );
  }

  @override
  Color? get backgroundColor => AppColors.background;

  @override
  ShapeBorder? get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.dw));
}
