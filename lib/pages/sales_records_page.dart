import '../source.dart';

class SalesRecordsPage extends StatefulWidget {
  const SalesRecordsPage({Key? key}) : super(key: key);

  @override
  State<SalesRecordsPage> createState() => _SalesRecordsPageState();
}

class _SalesRecordsPageState extends State<SalesRecordsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final RecordsPageBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<RecordsPageBloc>(context, listen: false);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.sales_page),
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildAddItemButton(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RecordsPageBloc, RecordsPageState>(
      bloc: bloc,
      builder: (_, state) {
        return state.when(
          loading: _buildLoading,
          content: _buildContent,
          success: (s, _) => _buildContent(s),
        );
      },
    );
  }

  Widget _buildLoading(RecordsSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
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

  Widget _buildContent(RecordsSupplements supp) {
    final recordList = supp.recordList;
    if (recordList.isEmpty) return _buildEmptyState();
    final daysWithRecord = bloc.getDaysWithRecords;

    return ListView.separated(
      itemCount: daysWithRecord.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (context, index) {
        final day = daysWithRecord[index];
        final dayRecords = recordList.where((e) => e.date.day == day).toList();
        return _buildDayRecords(dayRecords);
      },
      shrinkWrap: true,
    );
  }

  _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            Constants.kEmptyItemImage,
            height: 100.dh,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 30.dh),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.dw),
            child: const AppText(
              'No sales record has been added. Add one by clicking the button on a bottom-right corner.',
              alignment: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDayRecords(List<Record> dayRecords) {
    if (dayRecords.isEmpty) return Container();

    return DayRecordTile(
        date: dayRecords.first.date,
        recordList: dayRecords,
        dailyAmounts: bloc.getRecordsTotalAmount);
  }

  _buildAddItemButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const RecordsGroupPage())),
      child: const Icon(Icons.add, color: AppColors.onPrimary),
    );
  }
}
