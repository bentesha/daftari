import '../source.dart';

class SalesRecordsPage extends StatefulWidget {
  const SalesRecordsPage({Key? key}) : super(key: key);

  @override
  State<SalesRecordsPage> createState() => _SalesRecordsPageState();
}

class _SalesRecordsPageState extends State<SalesRecordsPage> {
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
      body: _buildBody(),
      appBar: const PageAppBar(title: 'Sales'),
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

  Widget _buildContent(GroupSupplements supp) {
    final groupList = supp.groupList;
    if (groupList.isEmpty) {
      return const EmptyStateWidget(message: emptyGroupMessage);
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

  static const emptyGroupMessage =
      'No sales record has been added. Add one by clicking the button on a bottom-right corner.';
}
