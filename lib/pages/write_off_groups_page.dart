import '../source.dart';

class WriteOffGroupsPage extends StatefulWidget {
  const WriteOffGroupsPage({Key? key}) : super(key: key);

  @override
  State<WriteOffGroupsPage> createState() => _WriteOffGroupsPageState();
}

class _WriteOffGroupsPageState extends State<WriteOffGroupsPage> {
  late final WriteOffPagesBloc bloc;

  @override
  void initState() {
     final groupsService = getService<GroupsService>(context);
    final writeOffsService = getService<WriteOffsService>(context);
    final writeOffsTypesService = getService<WriteOffsTypesService>(context);
    final productsService = getService<ProductsService>(context);
    bloc = WriteOffPagesBloc(writeOffsService, writeOffsTypesService,
        productsService, groupsService);
    bloc.init(Pages.write_off_groups_page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildBody(),
        appBar: const PageAppBar(title: 'Write Offs'),
        floatingActionButton: const AddButton(nextPage: GroupWriteOffsPage()));
  }

  Widget _buildBody() {
    return BlocBuilder<WriteOffPagesBloc, WriteOffPagesState>(
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

  Widget _buildLoading(WriteOffSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(WriteOffSupplements supp) {
    if (supp.groups.isEmpty) {
      return const EmptyStateWidget(message: emptyGroupMessage);
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (_, i) {
        final group = supp.groups[i];
        final groupAmount = bloc.getAmountByGroup(group.id);
        return WriteOffsGroupTile(group, groupAmount ?? 0);
      },
      itemCount: supp.groups.length,
    );
  }

  static const emptyGroupMessage =
      'No write-offs have been added. Add one by clicking the button on a bottom-right corner.';
}
