import '../widgets/bottom_total_amount_tile.dart';
import '../source.dart';

class GroupRecordsPage extends StatefulWidget {
  const GroupRecordsPage(this.group, {Key? key}) : super(key: key);

  final Document group;

  @override
  State<GroupRecordsPage> createState() => _GroupGroupPagesState();
}

class _GroupGroupPagesState extends State<GroupRecordsPage> {
  late final GroupPagesBloc bloc;

  @override
  void initState() {
    final recordsService = getService<RecordsService>(context);
    final groupsService = getService<GroupsService>(context);
    final itemsService = getService<ProductsService>(context);
    bloc = GroupPagesBloc(groupsService, recordsService, itemsService);
    bloc.init(group: widget.group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPagesBloc, GroupPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildLoading(GroupSupplements supp) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(GroupSupplements supp) {
    return Scaffold(
        appBar: _buildAppBar(supp.title),
        body: _buildRecords(supp),
        floatingActionButton: _buildAddItemButton(),
        bottomNavigationBar: BottomTotalAmountTile(bloc.getGroupTotalAmount));
  }

  _buildAppBar(String title) {
    return PageAppBar(
      title: title + ' Sales',
      actionIcons: const [Icons.edit_outlined],
      actionCallbacks: [_navigateToGroupEditPage],
    );
  }

  void _navigateToGroupEditPage() => push(DocumentEditPage(group: widget.group));

  Widget _buildRecords(GroupSupplements supp) {
    final recordList =/*  supp.getSpecificGroupRecords */ [];

    return supp.recordList.isEmpty
        ? const EmptyStateWidget(message: emptyRecordMessage)
        : ListView.separated(
            separatorBuilder: (_, index) =>
                const AppDivider(margin: EdgeInsets.zero),
            itemCount: recordList.length,
            itemBuilder: (_, index) => RecordTile(recordList[index]),
            shrinkWrap: true,
          );
  }

  _buildAddItemButton() {
    return BlocBuilder<GroupPagesBloc, GroupPagesState>(
        bloc: bloc,
        builder: (_, state) {
          final supp = state.supplements;
          return AddButton(nextPage: RecordEditPage(groupId: supp.id));
        });
  }

  static const emptyRecordMessage =
      'No records in this group yet. Create one by clicking on the Add Button on the bottom-right corner.';
}
