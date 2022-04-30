import 'package:inventory_management/source.dart';

enum Types { reports, dimensions }

class TypeSelectorDialog extends Dialog {
  const TypeSelectorDialog(
      {required this.onSelected,
      required this.currentType,
      required this.title,
      Key? key})
      : super(key: key);

  final ValueChanged<String> onSelected;
  final String currentType;
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
            children: _getTypes(Types.reports)
                .map((e) => AppTextButton(
                      text: e,
                      onPressed: () {
                        pop();
                        onSelected(e);
                      },
                      textStyle: TextStyle(
                          color: currentType == e
                              ? AppColors.onPrimary
                              : AppColors.onBackground2,
                          fontSize: 14.dw),
                      backgroundColor: currentType == e
                          ? AppColors.primary
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(20.dw),
                      height: 40.dh,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  Color? get backgroundColor => AppColors.background;

  @override
  ShapeBorder? get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.dw));
}

List<String> _getTypes(Types types) {
  return reports;
}

const reports = [
  'Sales',
  'Purchases',
  'Expenses',
  'Price List',
  'Stock Write-Offs',
  'Remaining Stock',
  'Profit & Loss'
];
