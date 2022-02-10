import '../source.dart';

class DateSelector extends StatefulWidget {
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
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    final date = DateFormatter.convertToDMY(widget.date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextButton(
          onPressed: widget.isEditable ? _showDatePicker : () {},
          isFilled: false,
          padding: EdgeInsets.symmetric(horizontal: 19.dw),
          child: ListTile(
            title: AppText(widget.title.toUpperCase(), opacity: .7),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.dh),
              child: AppText(date, weight: FontWeight.w500),
            ),
            trailing: widget.isEditable
                ? const Icon(Icons.chevron_right)
                : Container(width: .1),
          ),
        ),
      ],
    );
  }

  _showDatePicker() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: widget.date,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030));

    if (selectedDate != null) widget.onDateSelected(selectedDate);
  }
}
