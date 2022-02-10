import '../source.dart';

class RecordsGroupPage extends StatefulWidget {
  const RecordsGroupPage({Key? key}) : super(key: key);

  static void navigateTo(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (_) => const RecordsGroupPage()));

  @override
  State<RecordsGroupPage> createState() => _RecordsGroupPageState();
}

class _RecordsGroupPageState extends State<RecordsGroupPage> {
  late final RecordsPageBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<RecordsPageBloc>(context, listen: false);
    bloc.initGroupRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Add Records Group'),
      body: _buildBody(),
      floatingActionButton: _buildAddItemButton(),
    );
  }

  _buildBody() {
    return BlocConsumer<RecordsPageBloc, RecordsPageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: (s, _) => _buildContent(s));
        },
        listener: (_, state) {});
  }

  Widget _buildLoading(RecordsSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(RecordsSupplements supp) {
    return Column(
      children: [
        ValueSelector(
            title: 'Date',
            value: DateFormatter.convertToDMY(supp.date),
            onPressed: () => _showDatePicker(supp.date),
            errors: const {},
            isEditable: true,
            errorName: 'date')
      ],
    );
  }

  _buildAddItemButton() {
    return FloatingActionButton(
      onPressed: !bloc.hasItems
          ? () => _showEmptyItemsDialog()
          : () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const RecordsGroupPage())),
      child: const Icon(Icons.add, color: AppColors.onPrimary),
    );
  }

  _showEmptyItemsDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return const EmptyItemDialog();
        });
  }

  _showDatePicker(DateTime date) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030));

    if (selectedDate != null) bloc.updateDate(selectedDate);
  }
}
