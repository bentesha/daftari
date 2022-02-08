import '../source.dart';

class OpeningStockPage extends StatefulWidget {
  const OpeningStockPage({Key? key}) : super(key: key);

  @override
  State<OpeningStockPage> createState() => _OpeningStockPageState();
}

class _OpeningStockPageState extends State<OpeningStockPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ListView(
      children: [
        _buildTitle(),
        const DayTitle(),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tiles.length,
          separatorBuilder: (_, index) => const AppDivider(
              height: 1.5, color: AppColors.divider, margin: EdgeInsets.zero),
          itemBuilder: (_, index) {
            return _tiles[index];
          },
        ),
      ],
    );
  }

  final _tiles = const <AdjustableTile>[
    AdjustableTile(
      title: 'Work In Progress',
      totalPrice: 100000,
      description: 'Description if any for the work in progress.',
    ),
    AdjustableTile(title: 'Raw Materials', totalPrice: 200000),
    AdjustableTile(title: 'January Opening Stock', totalPrice: 500000),
  ];

  _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: AppText('Opening Stock',
                  size: 24.dw, weight: FontWeight.bold)),
          AppIconButton(
            onPressed: () => _navigateTo(const EditPage(
              pageTitle: 'Adding Opening Stock Item',
              titlesList: [
                'Item Title',
                'Amount, in Tzs',
                'Notes',
                'Date',
              ],
            )),
            icon: Icons.add,
          )
        ],
      ),
    );
  }

  void _navigateTo(Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}
