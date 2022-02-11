import '../source.dart';

class GroupEditPage extends StatefulWidget {
  const GroupEditPage({this.group, Key? key}) : super(key: key);

  final Group? group;

  static void navigateTo(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (_) => const GroupEditPage()));

  @override
  State<GroupEditPage> createState() => _GroupEditPageState();
}

class _GroupEditPageState extends State<GroupEditPage> {
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
      appBar: PageAppBar(
          title: 'Add Records Group', actionCallback: bloc.saveGroup),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<GroupPagesBloc, GroupPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        },
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) Navigator.pop(context);
        });
  }

  Widget _buildLoading(GroupSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(GroupSupplements supp) {
    return Column(
      children: [
        DateSelector(
          title: 'Date',
          onDateSelected: bloc.updateDate,
          date: supp.date,
          isEditable: true,
        ),
        const AppDivider(margin: EdgeInsets.zero),
        _buildGroupTitle(supp),
      ],
    );
  }

  _buildGroupTitle(GroupSupplements supp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCheckBox(supp),
        supp.isDateAsTitle
            ? Container()
            : AppTextField(
                text: supp.title,
                onChanged: bloc.updateTitle,
                hintText: '',
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                label: 'Group Title',
                error: 'title'),
      ],
    );
  }

  _buildCheckBox(GroupSupplements supp) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.dw),
      child: Row(
        children: [
          Checkbox(
              value: supp.isDateAsTitle, onChanged: bloc.updateDateAsTitle),
          SizedBox(width: 5.dw),
          const AppText('Use date as the title'),
        ],
      ),
    );
  }
}
