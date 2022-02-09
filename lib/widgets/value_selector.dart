import '../source.dart';

class ValueSelector extends StatelessWidget {
  const ValueSelector(
      {Key? key,
      required this.title,
      this.value,
      required this.onPressed,
      required this.errors,
      required this.isEditable,
      required this.errorName})
      : super(key: key);

  final String title;
  final String? value;
  final VoidCallback onPressed;
  final Map<String, String?> errors;
  final String errorName;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
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
              child: AppText(value ?? 'Tap to select',
                  opacity: value == null ? .5 : 1,
                  weight: value == null ? FontWeight.w100 : FontWeight.w500),
            ),
            trailing:
                isEditable ? const Icon(Icons.chevron_right) : Container(width: .1),
          ),
        ),
        _buildError(),
      ],
    );
  }

  _buildError() {
    final hasError = errors[errorName] != null;

    return hasError
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.dw),
            child: AppText(
              errors[errorName]!,
              color: AppColors.error,
              size: 14.dw,
            ),
          )
        : Container();
  }
}
