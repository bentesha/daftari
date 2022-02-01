import '../source.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.expenses_page),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _buildBottomNavBar() {
    return const MonthlyTotalTile(title: 'Total Expenses', amount: 4000000);
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
        showDrawerCallback: _openDrawer, title: "Expenses Records");
  }

  _buildBody() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DayTitle(),
        ListView.separated(
          separatorBuilder: (_, __) => Container(
            height: 1.5.dw,
            color: AppColors.divider,
          ),
          itemCount: _expensesList.length,
          itemBuilder: (_, index) {
            final category = _expensesList[index];
            return category;
          },
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        )
      ],
    );
  }

  final _expensesList = const <AdjustableTile>[
    AdjustableTile(title: 'Electricity Bills', totalPrice: 205000),
    AdjustableTile(
      title: 'Water Bills',
      totalPrice: 205000,
      description: 'An example description for water bills from DAWASCO.',
    ),
    AdjustableTile(title: 'Rent', totalPrice: 205000),
    AdjustableTile(title: 'Transportation Costs', totalPrice: 205000),
  ];
}
