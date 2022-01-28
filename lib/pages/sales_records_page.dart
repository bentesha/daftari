import '../source.dart';

class SalesRecordsPage extends StatefulWidget {
  const SalesRecordsPage({Key? key}) : super(key: key);

  @override
  State<SalesRecordsPage> createState() => _SalesRecordsPageState();
}

class _SalesRecordsPageState extends State<SalesRecordsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.sales_page),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
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

    return AppTopBar(showDrawerCallback: _openDrawer, title: "Sales Records");
  }

  _buildBody() {
    return ListView(
      children: [
        const DayTitle(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.dh),
          child: ListView.separated(
            separatorBuilder: (_, __) => const AppDivider(),
            itemCount: _recordsList.length,
            itemBuilder: (_, index) {
              return _recordsList[index];
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
        )
      ],
    );
  }

  _buildBottomNavBar() {
    final amount = Utils.convertToMoneyFormat(4000000);

    return Container(
      color: AppColors.secondary,
      width: ScreenSizeConfig.getFullWidth - 30.dw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: AppTextButton(
              onPressed: () {},
              height: 60.dh,
              padding: EdgeInsets.symmetric(horizontal: 15.dw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText('Today\'s Total',
                      style: AppTextStyles.subtitle.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.75))),
                  AppText(amount,
                      style: AppTextStyles.body.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary))
                ],
              ),
            ),
          ),
          _buildDivider(),
          Expanded(
            child: AppTextButton(
                onPressed: () {},
                height: 60.dh,
                child: Icon(
                  Icons.add,
                  size: 24.dw,
                  color: AppColors.onSecondary,
                )),
          )
        ],
      ),
    );
  }

  _buildDivider() {
    return Container(height: 40.dh, width: 2.dw, color: AppColors.divider);
  }

  final _recordsList = <RecordTile>[
    const RecordTile(
        title: 'Candle',
        unit: 'packs',
        totalPrice: 40000.00,
        unitPrice: 2000.00,
        quantity: 20),
    const RecordTile(
        title: 'Handbags',
        unit: 'bags',
        totalPrice: 320000.00,
        unitPrice: 8000.00,
        quantity: 4),
    const RecordTile(
        title: 'Candle',
        unit: 'packs',
        totalPrice: 40000.00,
        unitPrice: 2000.00,
        quantity: 20),
    const RecordTile(
        title: 'Candle',
        unit: 'packs',
        totalPrice: 40000.00,
        unitPrice: 2000.00,
        quantity: 20),
  ];
}
