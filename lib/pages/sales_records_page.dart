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

    return ListView.builder(
      itemCount: DateFormatter.getDaysInMonth(),
      itemBuilder: (context, i) {
        final index = DateFormatter.getDaysInMonth() - i + 1;
        final dayRecords =
            recordList.where((e) => e.date.day == index).toList();
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

  _buildDayRecords(List<Record> dayRecords) {
    if (dayRecords.isEmpty) return Container();

    return DayRecordTile(date: dayRecords.first.date, recordList: dayRecords);
  }

  _buildAddItemButton() {
    return FloatingActionButton(
      onPressed: !bloc.hasItems
          ? () => _showEmptyItemsDialog()
          : () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const RecordPage())),
      child: const Icon(Icons.add, color: AppColors.onPrimary),
    );
  }

  _showEmptyItemsDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return const EmptyItemDialog();
        });
  }
}

class DayRecordTile extends StatelessWidget {
  const DayRecordTile({Key? key, required this.date, required this.recordList})
      : super(key: key);

  final DateTime date;
  final List<Record> recordList;

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormatter.convertToDMY(date);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 10.dh),
        margin: EdgeInsets.only(right: 8.dw, left: 8.dw, top: 10.dh),
        color: Colors.grey.withOpacity(.45),
        child: Row(
          children: [
            AppText(dateString, color: AppColors.secondary),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 25.dw,
                  width: 25.dw,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: AppText(recordList.length.toString()),
                ),
                SizedBox(width: 10.dw),
                AppIconButton(
                  onPressed: () {},
                  icon: Icons.keyboard_arrow_down,
                  iconThemeData: Theme.of(context)
                      .iconTheme
                      .copyWith(size: 25.dw, color: AppColors.secondary),
                ),
              ],
            ))
          ],
        ));
  }
}
