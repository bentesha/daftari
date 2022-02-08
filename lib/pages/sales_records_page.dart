import '../source.dart';

class SalesRecordsPage extends StatefulWidget {
  const SalesRecordsPage({Key? key}) : super(key: key);

  @override
  State<SalesRecordsPage> createState() => _SalesRecordsPageState();
}

class _SalesRecordsPageState extends State<SalesRecordsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final SalesPageBloc bloc;

  @override
  void initState() {
    final recordsService = Provider.of<RecordsService>(context, listen: false);
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = SalesPageBloc(recordsService, itemsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesPageBloc, SalesPageState>(
      bloc: bloc,
      builder: (_, state) {
        return state.when(loading: _buildLoading, content: _buildContent);
      },
    );
  }

  Widget _buildLoading(RecordsSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(RecordsSupplements supp) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.sales_page),
      appBar: _buildAppBar(),
      body: _buildRecords(supp),
      floatingActionButton: _buildAddItemButton(supp.itemList),
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

  _buildRecords(RecordsSupplements supp) {
    final recordList = supp.recordList;
    if (recordList.isEmpty) return _buildEmptyState();

    return ListView(
      children: [
        const DayTitle(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.dh),
          child: ListView.separated(
            separatorBuilder: (_, __) => const AppDivider(),
            itemCount: recordList.length,
            itemBuilder: (_, index) {
              final record = recordList[index];
              return _buildItem(record);
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
        )
      ],
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

  _buildItem(Record record) {
    return RecordTile(record);
  }

  _buildAddItemButton(List<Item> itemList) {
    return FloatingActionButton(
      onPressed: () => _showItemDialog(itemList),
      child: const Icon(Icons.add, color: AppColors.onPrimary),
    );
  }

  _showItemDialog(List<Item> itemList) {
    showDialog(
        context: context,
        builder: (_) {
          return RecordDialog(itemList: itemList);
        });
  }
}
