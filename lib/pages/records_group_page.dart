import '../source.dart';

class RecordsGroupPage extends StatefulWidget {
  const RecordsGroupPage({Key? key}) : super(key: key);

  static void navigateTo(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (_) => const RecordsGroupPage()));

  @override
  State<RecordsGroupPage> createState() => _RecordsGroupPageState();
}

class _RecordsGroupPageState extends State<RecordsGroupPage> {
  late final GroupPagesBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<GroupPagesBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Add Records Group'),
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
                errors: supp.errors,
                text: supp.title,
                onChanged: bloc.updateTitle,
                hintText: '',
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                label: 'Group Title',
                errorName: 'title'),
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
