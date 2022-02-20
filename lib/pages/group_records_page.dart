import '../source.dart';

class GroupRecordsPage extends StatefulWidget {
  const GroupRecordsPage(this.group, {Key? key}) : super(key: key);

  final Group group;

  @override
  State<GroupRecordsPage> createState() => _GroupGroupPagesState();
}

class _GroupGroupPagesState extends State<GroupRecordsPage> {
  late final GroupPagesBloc bloc;

  @override
  void initState() {
    final recordsService = Provider.of<RecordsService>(context, listen: false);
    final groupsService = Provider.of<GroupsService>(context, listen: false);
    final itemsService = Provider.of<ProductsService>(context, listen: false);
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
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _buildAppBar(String title) {
    return PageAppBar(
      title: title + ' Sales',
      actionIcons: const [Icons.edit_outlined],
      actionCallbacks: [_navigateToGroupEditPage],
    );
  }

  void _navigateToGroupEditPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => GroupEditPage(group: widget.group)));
  }

  Widget _buildRecords(GroupSupplements supp) {
    final recordList = supp.getSpecificGroupRecords;

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

  _buildBottomNavBar() {
    final totalAmount = bloc.getGroupTotalAmount;
    final formatted = Utils.convertToMoneyFormat(bloc.getGroupTotalAmount);
    if (totalAmount == 0) return Container(height: .001);

    return Container(
      color: AppColors.primary,
      height: 55.dh,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Total Amount'.toUpperCase(), color: AppColors.onPrimary),
          AppText(formatted, size: 20.dw, color: AppColors.onPrimary),
        ],
      ),
    );
  }

  static const emptyRecordMessage =
      'No records in this group yet. Create one by clicking on the Add Button on the bottom-right corner.';
}
