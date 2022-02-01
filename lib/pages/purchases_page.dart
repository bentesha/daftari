import '../source.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({Key? key}) : super(key: key);

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.purchases_page),
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

    return AppTopBar(
        showDrawerCallback: _openDrawer, title: "Purchases Records");
  }

  _buildBody() {
    return ListView(
      children: [
        const DayTitle(),
        Container(
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
    return MonthlyTotalTile(
      title: 'Total Purchases',
      amount: 2560000,
      addCallback: _navigateToEditPage,
    );
  }

  void _navigateToEditPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const EditPage(
            pageTitle: 'Adding Purchases Record',
            titlesList: ['Item Title', 'Quantity Purchased', 'Notes'])));
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
