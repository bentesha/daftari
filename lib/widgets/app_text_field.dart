import '../source.dart';
import 'form_cell_error.dart';
import 'form_cell_label.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {this.error,
      this.text,
      required this.onChanged,
      this.maxLines = 1,
      required this.hintText,
      required this.keyboardType,
      this.textCapitalization = TextCapitalization.sentences,
      required this.label,
      this.letterSpacing,
      this.isPassword = false,
      this.isLoginPassword = false,
      this.shouldShowErrorText = true,
      this.isUpdatingOnRebuild = false,
      this.isEnabled = true,
      Key? key})
      : super(key: key);

  final String? error;
  final String? text;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String hintText, label;
  final double? letterSpacing;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool isPassword,
      isEnabled,
      isLoginPassword,
      shouldShowErrorText,
      isUpdatingOnRebuild;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final controller = TextEditingController();
  final isVisibleNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    final text = widget.text ?? '';
    final isEditing = text.trim().isNotEmpty;
    if (isEditing) {
      controller.text = widget.text ?? '';
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      TextPosition(offset: controller.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error != null;
    final border = hasError ? _errorBorder : _inputBorder;

    if (widget.isUpdatingOnRebuild) {
      controller.text = widget.text ?? '';
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }

    return Padding(
      padding: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormCellLabel(widget.label),
          // AppText(widget.label, opacity: .7),
          Container(
            height: widget.maxLines > 1 ? 90.dh : 40.dh,
            margin: EdgeInsets.only(top: 8.dh),
            child: ValueListenableBuilder<bool>(
                valueListenable: isVisibleNotifier,
                builder: (context, isVisible, snapshot) {
                  return TextField(
                      controller: controller,
                      onChanged: widget.onChanged,
                      maxLines: widget.maxLines,
                      minLines: 1,
                      onTap: _onTap,
                      enabled: widget.isEnabled,
                      keyboardType: widget.keyboardType,
                      textCapitalization: widget.textCapitalization,
                      style: TextStyle(
                        color: AppColors.onBackground,
                        letterSpacing: widget.letterSpacing,
                        fontSize: 16.dw,
                        fontWeight: FontWeight.w500,
                      ),
                      cursorColor: AppColors.primary,
                      obscureText: widget.isLoginPassword
                          ? true
                          : widget.isPassword && !isVisible,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: AppColors.onBackground.withOpacity(.5),
                            fontSize: 16.dw,
                            fontWeight: FontWeight.w100,
                          ),
                          fillColor: AppColors.surface,
                          suffixIcon: _suffixIcon(isVisible),
                          filled: true,
                          isDense: true,
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                          contentPadding: EdgeInsets.only(
                              left: 10.dw, top: 12.dw, bottom: 8.dw)));
                }),
          ),
          _buildError(),
        ],
      ),
    );
  }

  _buildError() {
    final hasError = widget.error != null;

    return hasError && widget.shouldShowErrorText
        ? Padding(
            padding: EdgeInsets.only(top: 8.dw),
            child: FormCellError(widget.error))
        : Container();
  }

  _suffixIcon(bool isVisible) {
    final hasNoText = controller.text.isEmpty;
    final emptyContainer = Container(width: 0.01);

    return hasNoText
        ? emptyContainer
        : widget.isPassword
            ? GestureDetector(
                onTap: () => isVisibleNotifier.value = !isVisible,
                child: Icon(
                    !isVisible ? Icons.visibility : Icons.visibility_off,
                    size: 16.dw,
                    color: AppColors.accent),
              )
            : emptyContainer;
  }

  void _onTap() {
    if (widget.isUpdatingOnRebuild) {
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }
  }

  final _inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(width: 0.0, color: Colors.transparent),
      borderRadius: BorderRadius.zero);

  final _errorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 1.2, color: AppColors.error));
}
