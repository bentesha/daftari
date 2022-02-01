import '../source.dart';

class StockManagement extends StatefulWidget {
  const StockManagement({Key? key}) : super(key: key);

  @override
  State<StockManagement> createState() => _StockManagementState();
}

class _StockManagementState extends State<StockManagement> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.stock_adjustment_page),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
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

    return AppTopBar(
        showDrawerCallback: _openDrawer, title: "Stock Management");
  }

  _buildBody() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildTitle(),
        _buildAdjustmentDetails(),
      ],
    );
  }

  _buildAdjustmentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.dh),
        _buildDetail('Opening Stock', 20005050.50),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        Padding(
          padding: EdgeInsets.only(left: 19.dw, bottom: 5.dh),
          child: AppText(
            'Reasons For Stock Loss'.toUpperCase(),
            color: AppColors.primaryVariant,
            weight: FontWeight.w500,
          ),
        ),
        _buildDetail('Stolen Items', 187300.00),
        _buildDetail('Expired Items', 20400.00),
        AppDivider(
            margin: EdgeInsets.only(bottom: 5.dh),
            color: AppColors.secondary,
            height: 2),
        _buildDetail('Net Stock Value', 1520000.00),
      ],
    );
  }

  _buildDetail(String title, double amount) {
    return Padding(
      padding: EdgeInsets.fromLTRB(19.dh, 0, 19.dw, 5.dh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title,
          ),
          AppText(
            Utils.convertToMoneyFormat(amount),
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  _buildTitle() {
    return PageTitle(
      title: 'Last Edited on 20.02.2021',
      actionCallback: _showBottomSheet,
      actionIcon: Icons.edit_outlined,
    );
  }

  void _showBottomSheet() {
    _scaffoldKey.currentState!.showBottomSheet((context) => AppBottomSheet(
        titles: const ['Edit Opening Stock', 'Edit Lost Items', 'Close'],
        callbacks: [() => _navigateTo(const OpeningStockPage()), null, null]));
  }

  void _navigateTo(Widget page) {
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}
