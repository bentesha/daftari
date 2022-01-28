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
      drawer: const AppDrawer(Pages.categories_page),
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
            style: AppTextStyles.body.copyWith(color: AppColors.primaryVariant),
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
          AppText(title,
              style:
                  AppTextStyles.body2.copyWith(color: AppColors.onBackground)),
          AppText(Utils.convertToMoneyFormat(amount)),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    _scaffoldKey.currentState!.showBottomSheet((context) => Container(
          color: AppColors.secondary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SheetOpeningTile(),
              _buildTextButton('Edit Opening Stock'),
              _buildTextButton('Edit Lost Items'),
              _buildTextButton('Close', textColor: AppColors.accent),
            ],
          ),
        ));
  }

  _buildTextButton(String text, {Color? textColor}) {
    return AppTextButton(
      onPressed: () => Navigator.pop(context),
      height: 40.dh,
      padding: EdgeInsets.only(left: 19.dw),
      text: text,
      alignment: Alignment.centerLeft,
      isFilled: false,
      textStyle:
          AppTextStyles.body2.copyWith(color: textColor ?? AppColors.onPrimary),
    );
  }

  _buildTitle() {
    return Container(
      color: AppColors.secondaryVariant,
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Last Edited on 20.02.2021',
              style: AppTextStyles.subtitle
                  .copyWith(color: AppColors.onSecondary.withOpacity(.75))),
          AppIconButton(
            onPressed: _showBottomSheet,
            icon: Icons.edit_outlined,
            iconColor: AppColors.onPrimary,
          )
        ],
      ),
    );
  }
}
