import '../source.dart';

class ValueSelector extends StatelessWidget {
  const ValueSelector({
    Key? key,
    required this.title,
    this.value,
    required this.onPressed,
    required this.error,
    required this.isEditable,
  }) : super(key: key);

  final String title;
  final String? value;
  final VoidCallback onPressed;
  final String? error;
  final bool isEditable;

  static const defaultText = 'Tap to select';

  @override
  Widget build(BuildContext context) {
    final _value = value == null
        ? defaultText
        : value!.trim().isEmpty
            ? defaultText
            : value!;
    final notSelectedYet = _value == defaultText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextButton(
          onPressed: isEditable ? onPressed : () {},
          isFilled: false,
          padding: EdgeInsets.symmetric(horizontal: 19.dw),
          child: ListTile(
            title: AppText(title.toUpperCase(), opacity: .7),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.dh),
              child: AppText(_value,
                  opacity: notSelectedYet ? .5 : 1,
                  weight: notSelectedYet ? FontWeight.w100 : FontWeight.w500),
            ),
            trailing: isEditable
                ? const Icon(Icons.chevron_right)
                : Container(width: .1),
          ),
        ),
        _buildError(),
      ],
    );
  }

  _buildError() {
    final hasError = error != null;

    return hasError
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 8.dh),
            child: AppText(
              error!,
              color: AppColors.error,
              size: 14.dw,
            ),
          )
        : Container();
  }
}
