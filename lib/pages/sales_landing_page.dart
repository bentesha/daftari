import 'package:inventory_management/blocs/dashboard/dashboard_bloc.dart';

import '../source.dart';
import 'today_documents_page.dart';

class SalesLandingPage extends StatefulWidget {
  const SalesLandingPage({Key? key}) : super(key: key);

  @override
  State<SalesLandingPage> createState() => _SalesLandingPageState();
}

class _SalesLandingPageState extends State<SalesLandingPage> {
  late DashBoardBloc dashboardBloc;

  @override
  void initState() {
    super.initState();
    dashboardBloc = BlocProvider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface2,
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
        children: [
          _buildStatsHeader(),
          const SizedBox(height: 40),
          const Text("Quick Actions",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20.dw,
            children: [
              _buildTile(Icons.arrow_forward, "View All", () {
                push(const SalesDocumentsPage());
              }),
              _buildTile(Icons.sell, "Add New Sales", () {
                push(const DocumentSalesPage());
              }),
              _buildTile(Icons.qr_code, "Add New Product", () {
                push(const ProductPage());
              }),
              _buildTile(Icons.bar_chart, "Sales Report", () {
                push(const ReportPage());
              }),
            ],
          )
        ],
      ),
    );
  }

  _buildStatsHeader() {
    final stats = context.watch<DashBoardBloc>().state.todayStats;

    return Container(
      padding: EdgeInsets.fromLTRB(10.dw, 10.dh, 10.dw, 10.dh),
      decoration: BoxDecoration(
          color: const Color(0xffB7CADB),
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: Column(
        children: [
          AppText(stats.date,
              style: const TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 10),
          Text("TZS " + stats.formattedSales,
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
              push(const TodayDocumentsPage());
            },
          )
        ],
      ),
    );
  }

  _buildTile(IconData icon, String label, VoidCallback onPressed) {
    return AppTextButton(
      width: 180.dw,
      height: 140.dw,
      alignment: Alignment.centerLeft,
      backgroundColor: AppColors.onPrimary,
      borderRadius: BorderRadius.all(Radius.circular(10.dw)),
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, color: Colors.black54),
          AppText(label, size: 16.dw, color: AppColors.primary)
        ],
      ),
    );
  }
}
