part of 'bar_rod.dart';

class BarPainter extends CustomPainter {
  BarPainter(this.value, this.valueColor, this.lineColor);
  final double value;
  final Color valueColor;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final rect = Rect.fromLTWH(0, height, width, -height * value);
    final paint = Paint()..color = valueColor;
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2;

    final p1 = Offset(width / 2, height);
    final p2 = Offset(width / 2, 0);

    canvas.drawLine(p1, p2, linePaint);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
