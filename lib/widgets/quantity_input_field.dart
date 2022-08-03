import '../source.dart';
import 'form_cell_label.dart';

class QuantityInputField extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;
  final bool enabled;
  const QuantityInputField(
      {Key? key,
      required this.initialValue,
      required this.enabled,
      required this.onChanged})
      : super(key: key);

  @override
  State<QuantityInputField> createState() => _QuantityInputFieldState();
}

class _QuantityInputFieldState extends State<QuantityInputField> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormCellLabel("Quantity"),
          const SizedBox(height: 10),
          Container(
            height: 50,
            width: double.maxFinite,
            color: AppColors.surface,
            child: IconTheme(
              data: IconThemeData(
                  color: widget.enabled ? Colors.black : Colors.grey),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (currentValue == 1 || !widget.enabled) return;
                        currentValue -= 1;
                        setState(() {});
                      },
                      icon: const Icon(Icons.remove)),
                  Expanded(
                      child: Text(
                    currentValue.toString(),
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.dw, fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                      onPressed: () {
                        if (!widget.enabled) return;
                        currentValue += 1;
                        setState(() {});
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
