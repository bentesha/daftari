import 'package:inventory_management/widgets/form_cell_label.dart';

import '../source.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({
    Key? key,
    required this.title,
    required this.onDateSelected,
    required this.isEditable,
    required this.date,
  }) : super(key: key);

  final String title;
  final void Function(DateTime) onDateSelected;
  final bool isEditable;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final formattedDate = Utils.dateToString(date);

    _showDatePicker() async {
      final selectedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2022),
          lastDate: DateTime.now());

      if (selectedDate != null) onDateSelected(selectedDate);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextButton(
          onPressed: isEditable ? _showDatePicker : () {},
          isFilled: false,
          padding: EdgeInsets.symmetric(horizontal: 19.dw),
          child: ListTile(
            title: /* AppText(title.toUpperCase(), opacity: .7) */  FormCellLabel(title),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.dh),
              child: AppText(formattedDate, weight: FontWeight.w500),
            ),
            trailing: isEditable
                ? const Icon(Icons.chevron_right)
                : Container(width: .1),
          ),
        ),
      ],
    );
  }
}
