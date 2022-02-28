import 'package:inventory_management/widgets/bottom_total_amount_tile.dart';
import '../source.dart';

class GroupWriteOffsPage extends StatefulWidget {
  const GroupWriteOffsPage({this.group, Key? key}) : super(key: key);

  final Group? group;

  @override
  State<GroupWriteOffsPage> createState() => _GroupWriteOffsPageState();
}

class _GroupWriteOffsPageState extends State<GroupWriteOffsPage> {
  late final WriteOffPagesBloc bloc;
  late final bool isEditing;
  final _isActionActiveNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    isEditing = widget.group != null;
    final groupsService = getService<GroupsService>(context);
    final writeOffsService = getService<WriteOffsService>(context);
    final writeOffsTypesService = getService<WriteOffsTypesService>(context);
    final productsService = getService<ProductsService>(context);
    bloc = WriteOffPagesBloc(writeOffsService, writeOffsTypesService,
        productsService, groupsService);
    _initAppBarAction();
    bloc.init(Pages.group_write_offs_page, null, widget.group?.id);
    super.initState();
  }

  _initAppBarAction() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.group != null) _isActionActiveNotifier.value = false;
      if (widget.group == null) _isActionActiveNotifier.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildContent(WriteOffSupplements supp) {
    return Scaffold(
      appBar: _buildAppBar(supp.group.id),
      body: _buildBody(supp),
      floatingActionButton: _buildAddButton(supp.group.id),
    );
  }

  _buildAppBar(String groupId) {
    final hasNoGroup = groupId.isEmpty;
    return AppBar(
        title: AppText('Write Off',
            size: 22.dw, style: Theme.of(context).appBarTheme.titleTextStyle!),
        actions: [
          hasNoGroup
              ? AppIconButton(
                  icon: Icons.done,
                  margin: EdgeInsets.only(right: 19.dw),
                  onPressed: bloc.saveGroup)
              : Container()
        ]);
  }

  Widget _buildBody(WriteOffSupplements supp) {
    return ListView(
      children: [
        DateSelector(
            title: 'Date',
            onDateSelected: bloc.updateGroupDate,
            isEditable: true,
            date: supp.group.date),
        ValueSelector(
          title: 'Type',
          value: supp.group.type,
          error: supp.errors['type'],
          isEditable: !isEditing,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ItemsSearchPage<WriteOffType>())),
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
            error: supp.errors['title'],
            text: supp.group.title,
            onChanged: bloc.updateGroupTitle,
            hintText: '',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            label: 'TITLE'),
        _buildItems(supp),
      ],
    );
  }

  _buildItems(WriteOffSupplements supp) {
    final writeOffs = supp.writeOffs;
    if (supp.group.id.isEmpty) return _buildEmptyState(emptyGroupMessage);
    if (writeOffs.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 19.dw),
          child: const AppText('Products', weight: FontWeight.bold),
        ),
        ListView.separated(
          itemCount: writeOffs.length,
          separatorBuilder: (_, __) =>
              const AppDivider(margin: EdgeInsets.zero),
          itemBuilder: (_, i) {
            final writeOff = writeOffs[i];
            // final category = bloc.getCategoryById(expense.categoryId);
            return WriteOffTile(writeOff);
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }

  _buildEmptyState(String message) {
    return Container(
        height: 500.dh,
        alignment: Alignment.center,
        child: EmptyStateWidget(message: message));
  }

  _buildAddButton(String groupId) {
    final hasNoGroup = groupId.isEmpty;
    if (hasNoGroup) return Container();
    return AddButton(nextPage: WriteOffEditPage(groupId: groupId));
  }

  static const emptyExpensesMessage = 'No products have been added yet.';
  static const emptyGroupMessage = 'Start by creating a new group.';
}
