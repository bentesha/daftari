import '../source.dart';

class DayRecordsPage extends StatefulWidget {
  const DayRecordsPage({Key? key, required this.day, required this.title})
      : super(key: key);

  final int day;
  final String title;

  @override
  State<DayRecordsPage> createState() => _DayRecordsPageState();
}

class _DayRecordsPageState extends State<DayRecordsPage> {
  late final RecordsPageBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<RecordsPageBloc>(context, listen: false);
    bloc.initDayRecords(widget.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return PageAppBar(title: widget.title + ' Sales', hasAction: false);
  }

  Widget _buildLoading(RecordsSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildBody() {
    return BlocBuilder<RecordsPageBloc, RecordsPageState>(builder: (_, state) {
      return state.when(
          loading: _buildLoading,
          content: _buildContent,
          success: (s, _) => _buildContent(s));
    });
  }

  Widget _buildContent(RecordsSupplements supp) {
    final recordList = bloc.getSpecificDayRecords;
    final totalAmount = Utils.convertToMoneyFormat(bloc.getDayTotalAmount);

    return ListView(
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
              AppText('Total Amount'.toUpperCase(), weight: FontWeight.w500),
              AppText(totalAmount, weight: FontWeight.bold, size: 20.dw),
            ],
          ),
        )
      ],
    );
  }
}
