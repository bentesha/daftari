import 'package:inventory_management/source.dart';
import '../../source.dart';

part 'bar_rod_painter.dart';

class BarRod extends StatelessWidget {
  const BarRod(
      {required this.value,
      required this.valueColor,
      required this.lineColor,
      required this.title,
      Key? key})
      : super(key: key);

  final double value;
  final String title;
  final Color valueColor, lineColor;

  @override
  Widget build(BuildContext context) {
    final data = (value * 100).round();

    return Container(
      width: 50.dw,
      margin: EdgeInsets.symmetric(vertical: 15.dh, horizontal: 5.dw),
      child: Column(
        children: [
          AppText(data.toString() + '%',
              style:
                  TextStyle(fontSize: 14.dw, fontFamily: kFontFam2)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RotatedBox(quarterTurns: 3, child: AppText(title, size: 14.dw)),
              SizedBox(
                  height: 200.dh,
                  width: 20.dw,
                  child: CustomPaint(
                      painter: BarPainter(value, valueColor, lineColor))),
            ],
          ),
        ],
      ),
    );
  }
}
