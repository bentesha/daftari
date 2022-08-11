import '../../../blocs/dashboard/dashboard_bloc.dart';
import "../../../source.dart";

class CurrentDateStatsHeader extends StatelessWidget {
  final double total;
  final VoidCallback onViewDetailsTap;
  const CurrentDateStatsHeader(
      {Key? key, required this.total, required this.onViewDetailsTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<DashBoardBloc>().state.todayStats;
    final isLoading = context.watch<DashBoardBloc>().state.isLoading;

    return Container(
      padding: EdgeInsets.fromLTRB(10.dw, 10.dh, 10.dw, 10.dh),
      decoration: BoxDecoration(
          color: const Color(0xffB7CADB),
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: isLoading
          ? Container(
              height: 100,
              alignment: Alignment.center,
              child: const SizedBox(
                  height: 35, width: 35, child: CircularProgressIndicator()))
          : Column(
              children: [
                AppText(stats.date,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 10),
                Text("TZS " + Utils.convertToMoneyFormat(total),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87)),
                const SizedBox(height: 10),
                AppTextButton(
                  text: "View Details",
                  textColor: stats.sales == 0.0 ? Colors.grey : Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30.dw),
                  height: 45,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {
                    if (stats.sales == 0.0) return;
                    onViewDetailsTap();
                  },
                )
              ],
            ),
    );
  }
}
