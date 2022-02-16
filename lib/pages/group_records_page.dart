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
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = GroupPagesBloc(groupsService, recordsService, itemsService);
    bloc.init(group: widget.group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildAddItemButton(),
    );
  }

  _buildAppBar() {
    return PageAppBar(
      title: widget.group.title + ' Sales',
      actionIcon: Icons.edit_outlined,
      actionCallback: _navigateToGroupEditPage,
    );
  }

  void _navigateToGroupEditPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => GroupEditPage(group: widget.group)));
  }

  Widget _buildLoading(GroupSupplements supp) {
    return const Center(child: CircularProgressIndicator());
  }

  _buildBody() {
    return BlocBuilder<GroupPagesBloc, GroupPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildContent(GroupSupplements supp) {
    final recordList = supp.getSpecificGroupRecords;
    final totalAmount = Utils.convertToMoneyFormat(bloc.getGroupTotalAmount);

    return supp.recordList.isEmpty
        ? const EmptyStateWidget(decscription: emptyRecordMessage)
        : ListView(
            children: [
              ListView.separated(
                separatorBuilder: (_, index) =>
                    const AppDivider(margin: EdgeInsets.zero),
                itemCount: recordList.length,
                itemBuilder: (_, index) => RecordTile(recordList[index]),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              AppDivider(
                height: 2,
                color: AppColors.secondary,
                margin: EdgeInsets.only(bottom: 8.dh),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.dw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText('Total Amount'.toUpperCase(),
                        weight: FontWeight.w500),
                    AppText(totalAmount, weight: FontWeight.bold, size: 20.dw),
                  ],
                ),
              )
            ],
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
