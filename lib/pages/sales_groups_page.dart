import '../source.dart';

class SalesRecordsPage extends StatefulWidget {
  const SalesRecordsPage({Key? key}) : super(key: key);

  @override
  State<SalesRecordsPage> createState() => _SalesRecordsPageState();
}

class _SalesRecordsPageState extends State<SalesRecordsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final GroupPagesBloc bloc;

  @override
  void initState() {
    final recordsService = Provider.of<RecordsService>(context, listen: false);
    final groupsService = Provider.of<GroupsService>(context, listen: false);
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = GroupPagesBloc(groupsService, recordsService, itemsService);
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
      floatingActionButton: const AddButton(nextPage: GroupEditPage()),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<GroupPagesBloc, GroupPagesState>(
      bloc: bloc,
      builder: (_, state) {
        return state.when(
          loading: _buildLoading,
          content: _buildContent,
          success: _buildContent,
        );
      },
    );
  }

  Widget _buildLoading(GroupSupplements supp) {
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

  Widget _buildContent(GroupSupplements supp) {
    final groupList = supp.groupList;
    if (groupList.isEmpty) {
      return const EmptyStateWidget(
          decscription:
              'No sales record has been added. Add one by clicking the button on a bottom-right corner.');
    }

    return ListView.separated(
      itemCount: groupList.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (context, index) {
        final group = groupList[index];
        final groupRecords =
            supp.recordList.where((e) => e.id == group.id).toList();

        return GroupTile(
            group: group,
            recordList: groupRecords,
            groupAmount: supp.groupAmounts[group.id] ?? 0);
      },
      shrinkWrap: true,
    );
  }
}
