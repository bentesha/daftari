import '../widgets/bottom_total_amount_tile.dart';
import '../source.dart';

class GroupRecordsPage extends StatefulWidget {
  const GroupRecordsPage(this.group, {Key? key}) : super(key: key);

  final Document group;

  @override
  State<GroupRecordsPage> createState() => _GroupGroupPagesState();
}

class _GroupGroupPagesState extends State<GroupRecordsPage> {
  late final SalesDocumentsPagesBloc bloc;

  @override
  void initState() {
    final salesService = getService<SalesService>(context);
    final itemsService = getService<ProductsService>(context);
    bloc = SalesDocumentsPagesBloc(salesService, itemsService);
    bloc.init(widget.group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildLoading(SalesDocumentSupplements supp) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(SalesDocumentSupplements supp) {
    return Scaffold(
        appBar: _buildAppBar(supp.document.form.title),
        body: _buildRecords(supp),
        floatingActionButton: _buildAddItemButton(),
        bottomNavigationBar: BottomTotalAmountTile(supp.document.form.total));
  }

  _buildAppBar(String title) {
    return PageAppBar(
      title: title + ' Sales',
      actionIcons: const [Icons.edit_outlined],
      actionCallbacks: [_navigateToGroupEditPage],
    );
  }

  void _navigateToGroupEditPage() =>
      push(DocumentEditPage(group: widget.group));

  Widget _buildRecords(SalesDocumentSupplements supp) {
    final recordList =
        supp.document.maybeWhen(sales: (_, s) => s, orElse: () => []);

    return recordList.isEmpty
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
    return BlocBuilder<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
        bloc: bloc,
        builder: (_, state) {
          final supp = state.supplements;
          return AddButton(
              nextPage: RecordEditPage(groupId: supp.document.form.id));
        });
  }

  static const emptyRecordMessage =
      'No records in this group yet. Create one by clicking on the Add Button on the bottom-right corner.';
}
