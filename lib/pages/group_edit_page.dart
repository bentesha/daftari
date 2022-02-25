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
  bool isEditing = false;

  @override
  void initState() {
    final recordsService = getService<RecordsService>(context);
    final groupsService = getService<GroupsService>(context);
    final itemsService = getService<ProductsService>(context);
    bloc = GroupPagesBloc(groupsService, recordsService, itemsService);

    final group = widget.group;
    isEditing = group != null;
    bloc.init(group: group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  Widget _buildContent(GroupSupplements supp) {
    final hasTitleError = supp.errors['title_exists'] != null;

    return Scaffold(
      appBar: PageAppBar(
          title: '${isEditing ? 'Edit' : 'New'} Sales Group',
          actionIcons: const [Icons.done],
          actionCallbacks: hasTitleError
              ? []
              : isEditing
                  ? [bloc.editGroup]
                  : [bloc.saveGroup]),
      body: _buildGroupDetails(supp),
    );
  }

  Widget _buildLoading(GroupSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildGroupDetails(GroupSupplements supp) {
    final titleExistsError = supp.errors['title_exists'];
    if (titleExistsError != null) return _buildTitleError(titleExistsError);

    return Column(
      children: [
        DateSelector(
          title: 'Date',
          onDateSelected: bloc.updateDate,
          date: supp.date,
          isEditable: !isEditing,
        ),
        const AppDivider(margin: EdgeInsets.zero),
        _buildGroupTitle(supp),
      ],
    );
  }

  _buildTitleError(String message) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_outlined,
              size: 45.dw, color: AppColors.error),
          SizedBox(height: 20.dh),
          AppText(message, opacity: .7, alignment: TextAlign.center)
        ],
      ),
    ));
  }

  _buildGroupTitle(GroupSupplements supp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        supp.canUseDateAsTitle ? _buildCheckBox(supp) : SizedBox(height: 15.dh),
        supp.canUseDateAsTitle && supp.isDateAsTitle
            ? Container()
            : AppTextField(
                text: supp.title,
                onChanged: bloc.updateTitle,
                hintText: '',
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                label: 'Title',
                error: supp.errors['title']),
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
