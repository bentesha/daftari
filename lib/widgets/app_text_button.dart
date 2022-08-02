import '../source.dart';

class AppTextButton extends StatefulWidget {
  const AppTextButton(
      {this.icon,
      this.padding,
      this.margin,
      this.height,
      this.width,
      this.text,
      this.alignment,
      this.borderRadius,
      this.child,
      this.withIcon = false,
      this.isFilled = true,
      this.textStyle,
      this.iconColor = AppColors.onPrimary,
      this.textColor = AppColors.onPrimary,
      required this.onPressed,
      this.backgroundColor = AppColors.background,
      Key? key})
      : super(key: key);

  final IconData? icon;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? text;
  final bool withIcon, isFilled;
  final Widget? child;
  final Alignment? alignment;
  final TextStyle? textStyle;
  final Color iconColor, textColor, backgroundColor;

  @override
  _AppTextButtonState createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Color?> animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 0),
        vsync: this);
    animation = ColorTween(
            end: Colors.grey.withOpacity(.25),
            begin:
                widget.isFilled ? widget.backgroundColor : Colors.transparent)
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
          widget.onPressed();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: _child(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => controller.forward(),
          child: Container(
              height: widget.height,
              width: widget.width,
              margin: widget.margin ?? EdgeInsets.zero,
              padding: widget.padding ?? EdgeInsets.zero,
              alignment: widget.alignment ?? Alignment.center,
              decoration: BoxDecoration(
                  color: animation.value,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(5)),
              child: child),
        );
      },
    );
  }

  _child() {
    final hasProvidedChild = widget.child != null;

    return hasProvidedChild
        ? widget.child
        : widget.withIcon
            ? Row(
                mainAxisAlignment: widget.alignment == Alignment.centerLeft
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                    Icon(widget.icon ?? Icons.share,
                        color: widget.iconColor, size: 22.dw),
                    SizedBox(width: 15.dw),
                    _text(),
                  ])
            : _text();
  }

  _text() {
    return AppText(widget.text ?? 'Click Me',
        weight: widget.textStyle?.fontWeight ?? FontWeight.w400,
        size: widget.textStyle?.fontSize ?? 15.dw,
        color: widget.textStyle?.color ?? widget.textColor);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
