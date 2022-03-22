import '../source.dart';
import '../widgets/charts/bar_charts_flutter.dart';
import '../widgets/charts/bar_fl_charts.dart';
import '../widgets/charts/line_charts_flutter.dart';
import '../widgets/charts/line_fl_charts.dart';
import '../widgets/charts/line_syncfusion.dart';
import '../widgets/charts/pie_charts_flutter.dart';
import '../widgets/charts/pie_fl_chart.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        drawer: const AppDrawer(),
        body: _buildCharts());
  }

  _buildAppBar() {
    final isScaffoldStateNull = _scaffoldKey.currentState == null;
    _openDrawer() {
      if (isScaffoldStateNull) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scaffoldKey.currentState!.openDrawer();
        });
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    }

    return AppTopBar(showDrawerCallback: _openDrawer);
  }

  _buildCharts() {
    return ListView(children: const [
      LineChart(),
      SizedBox(height: 50),
      LineChart2(),
      SizedBox(height: 50),
      LineChart3(),
      SizedBox(height: 50),
      BarChart(),
      SizedBox(height: 50),
      BarChart2(),
      SizedBox(height: 50),
      PieChart(),
      SizedBox(height: 50),
      PieChart2(),
      SizedBox(height: 50),
    ]);
  }
}
