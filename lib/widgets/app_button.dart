import '../source.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {required this.child,
      this.height,
      this.width,
      this.margin,
      required this.onPressed,
      this.backgroundColor = Colors.transparent,
      this.highlightDetails,
      this.radius = 0,
      Key? key})
      : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double? height, width;
  final VoidCallback onPressed;

  ///border radius
  final double radius;
  final Color backgroundColor;
  final HighlightDetails? highlightDetails;

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse().then((value) => widget.onPressed());
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        child: widget.child,
        builder: (context, child) {
          final shouldHideRipple =
              controller.isCompleted || controller.isDismissed;

          return GestureDetector(
            onTap: () => controller.forward(),
            child: Container(
              margin: widget.margin,
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.value == 0
                    ? widget.backgroundColor
                    : Colors.transparent,
              ),
              child: shouldHideRipple
                  ? child
                  : CustomPaint(
                      painter: TappedButtonRipplePainter(
                          widget.radius,
                          widget.highlightDetails ??
                              HighlightDetails.noExpansion()),
                      child: child),
            ),
          );
        });
  }
}

class TappedButtonRipplePainter extends CustomPainter {
  final double radius;
  final HighlightDetails highlightDetails;
  TappedButtonRipplePainter(this.radius, this.highlightDetails);

  @override
  void paint(Canvas canvas, Size size) {
    final dx = highlightDetails.dx, dh = highlightDetails.dh;
    final width = size.width + dx, height = size.height + dh;
    final paint = Paint()..color = Colors.grey.withOpacity(.25);
    final rect = Rect.fromLTWH(-dx / 2, -dh / 2, width, height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HighlightDetails {
  final double dh, dx;
  const HighlightDetails(this.dx, this.dh);

  HighlightDetails.noExpansion()
      : dx = 20.dw,
        dh = 10.dh;
}
