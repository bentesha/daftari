import '../source.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {required this.errors,
      required this.text,
      required this.onChanged,
      this.maxLines = 1,
      required this.hintText,
      required this.keyboardType,
      this.textCapitalization = TextCapitalization.sentences,
      required this.label,
      required this.errorName,
      this.letterSpacing,
      this.isPassword = false,
      this.isLoginPasswrd = false,
      Key? key})
      : super(key: key);

  final Map<String, dynamic> errors;
  final String? text;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String hintText, errorName, label;
  final double? letterSpacing;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool isPassword;
  final bool isLoginPasswrd;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final controller = TextEditingController();
  final isVisibleNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    final text = widget.text ?? '';
    final isEditing = text.trim().isNotEmpty;
    if (isEditing) {
      controller.text = text;
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errors.containsKey(widget.errorName);
    final border = hasError ? errorBorder : _inputBorder;
    final hasNoText = controller.text.isEmpty;
    final emptyContainer = Container(width: 0.01);

    return Padding(
      padding: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(widget.label,
              style:
                  AppTextStyles.body2.copyWith(color: AppColors.onBackground)),
          Container(
            height: 40.dh,
            margin: EdgeInsets.only(top: 8.dh),
            child: ValueListenableBuilder<bool>(
                valueListenable: isVisibleNotifier,
                builder: (context, isVisible, snapshot) {
                  return TextField(
                      controller: controller,
                      onChanged: widget.onChanged,
                      maxLines: widget.maxLines,
                      minLines: 1,
                      keyboardType: widget.keyboardType,
                      textCapitalization: widget.textCapitalization,
                      style: TextStyle(
                        color: AppColors.onBackground,
                        letterSpacing: widget.letterSpacing,
                        fontSize: 16.dw,
                      ),
                      cursorColor: AppColors.primary,
                      obscureText: widget.isLoginPasswrd
                          ? true
                          : widget.isPassword && !isVisible,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: AppColors.onBackground2,
                            fontSize: 14.dw,
                          ),
                          fillColor: AppColors.surface,
                          suffixIcon: hasNoText
                              ? emptyContainer
                              : widget.isPassword
                                  ? GestureDetector(
                                      onTap: () =>
                                          isVisibleNotifier.value = !isVisible,
                                      child: Icon(
                                          !isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 16.dw,
                                          color: AppColors.accent),
                                    )
                                  : emptyContainer,
                          filled: true,
                          isDense: true,
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                          contentPadding: EdgeInsets.only(
                              left: 10.dw, top: 12.dw, bottom: 8.dw)));
                }),
          ),
          hasError
              ? Padding(
                  padding: EdgeInsets.only(top: 8.dw),
                  child: AppText(
                    widget.errors[widget.errorName]!,
                    color: AppColors.error,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  final _inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(width: 0.0, color: Colors.transparent),
      borderRadius: BorderRadius.zero);

  final errorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 1.2, color: Colors.white70));
}
