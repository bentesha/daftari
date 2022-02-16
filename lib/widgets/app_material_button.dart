import '../source.dart';

class AppMaterialButton extends StatefulWidget {
  const AppMaterialButton(
      {this.padding,
      this.margin,
      this.height,
      this.width,
      this.alignment,
      required this.child,
      this.isFilled = true,
      required this.onPressed,
      this.backgroundColor = AppColors.primary,
      Key? key})
      : super(key: key);

  final double? height;
  final double? width;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isFilled;
  final Widget child;
  final Alignment? alignment;
  final Color backgroundColor;

  @override
  _AppMaterialButtonState createState() => _AppMaterialButtonState();
}

class _AppMaterialButtonState extends State<AppMaterialButton>
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
      child: widget.child,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => controller.forward(),
          child: Container(
              height: widget.height,
              width: widget.width,
              margin: widget.margin ?? EdgeInsets.zero,
              padding: widget.padding ?? EdgeInsets.zero,
              alignment: widget.alignment ?? Alignment.center,
              color: animation.value,
              child: child),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
