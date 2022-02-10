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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: 'Add Record'), body: _buildBody());
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
            onPressed: () {},
            errors: supp.errors,
            isEditable: true,
            errorName: 'date')
      ],
    );
  }
}
