import '../source.dart';

class BarcodeField extends StatefulWidget {
  const BarcodeField(
      {required this.error,
      required this.text,
      required this.onChanged,
      Key? key})
      : super(key: key);

  final String? error;
  final String? text;
  final ValueChanged<String> onChanged;

  @override
  _BarcodeFieldState createState() => _BarcodeFieldState();
}

class _BarcodeFieldState extends State<BarcodeField> {
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
    final hasError = widget.error != null;
    final border = hasError ? _errorBorder : _inputBorder;

    return Padding(
      padding: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText('Barcode ( Optional )', opacity: .7),
          Container(
              height: 40.dh,
              margin: EdgeInsets.only(top: 8.dh),
              child: TextField(
                  controller: controller,
                  onChanged: widget.onChanged,
                  maxLines: 1,
                  minLines: 1,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: AppColors.onBackground,
                    fontSize: 16.dw,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(
                        color: AppColors.onBackground.withOpacity(.5),
                        fontSize: 16.dw,
                        fontWeight: FontWeight.w100,
                      ),
                      fillColor: AppColors.surface,
                      suffixIcon: _suffixIcon(),
                      filled: true,
                      isDense: true,
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      contentPadding: EdgeInsets.only(
                          left: 10.dw, top: 12.dw, bottom: 8.dw)))),
          _buildError(),
        ],
      ),
    );
  }

  _buildError() {
    final hasError = widget.error != null;

    return hasError
        ? Padding(
            padding: EdgeInsets.only(top: 8.dw),
            child: AppText(
              widget.error!,
              color: AppColors.error,
              size: 14.dw,
            ),
          )
        : Container();
  }

  _suffixIcon() {
    return AppIconButton(
        onPressed: () {},
        icon: Icons.document_scanner,
        iconThemeData: Theme.of(context)
            .iconTheme
            .copyWith(color: AppColors.secondary.withOpacity(.7), size: 22.dw));
  }

  final _inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(width: 0.0, color: Colors.transparent),
      borderRadius: BorderRadius.zero);

  final _errorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 1.2, color: AppColors.error));
}
