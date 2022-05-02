import 'package:inventory_management/source.dart';

enum Types { reports, dimensions }

class TypeSelectorDialog extends Dialog {
  const TypeSelectorDialog(
      {required this.onSelected,
      required this.currentType,
      required this.title,
      required this.type,
      Key? key})
      : super(key: key);

  final ValueChanged<String> onSelected;
  final String currentType;
  final String title;
  final Types type;

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
            children: _getTypes(type)
                .map((e) => AppTextButton(
                      text: e,
                      onPressed: () {
                        pop();
                        if (type == Types.reports) onSelected(e);
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

List<String> _getTypes(Types type) {
  if (type == Types.reports) return reports;
  return timeDimension;
}

const reports = [
  'Sales',
  'Expenses',
  'Price List',
  'Remaining Stock',
  'Profit & Loss',
];

const timeDimension = [
  'Last 7 days',
  'Last 15 days',
  'Last 30 days',
  'Last 3 months',
  'Last 12 months'
];
