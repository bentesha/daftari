import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/breakdown_datatable.dart';

class SalesReport extends StatelessWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.dh),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppIconButton(
                  buttonColor: AppColors.primary,
                  icon: FontAwesomeIcons.minus,
                  height: 30.dw,
                  width: 30.dw,
                  margin: EdgeInsets.symmetric(horizontal: 15.dw),
                  iconThemeData:
                      IconThemeData(size: 20.dw, color: AppColors.onPrimary),
                  onPressed: () {}),
              AppText('Sales', size: 20.dw, weight: FontWeight.bold),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 60.dw, right: 15.dw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText('Last 7 days'),
                AppButton(
                    backgroundColor: Colors.white,
                    child: const AppText('Change filter',
                        color: AppColors.primary),
                    onPressed: () {})
              ],
            ),
          ),
          const AppDivider(color: AppColors.onBackground, height: 2),
          const Flexible(child: BreakDownDataTable(true))
        ],
      ),
    );
  }
}
