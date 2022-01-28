import '../source.dart';

class SheetOpeningTile extends StatelessWidget {
  const SheetOpeningTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40.dw,
        height: 4.dw,
        margin: EdgeInsets.only(top: 8.dh, bottom: 10.dh),
        decoration: BoxDecoration(
            color: AppColors.onSecondary.withOpacity(.35),
            borderRadius: BorderRadius.all(Radius.circular(2.dw))),
      ),
    );
  }
}
