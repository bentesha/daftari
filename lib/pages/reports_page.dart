import '../source.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Reports'),
      body: Column(
        children: const [AppText('Sales')],
      ),
    );
  }
}

const labels = [
  'Sales',
  'Purchases',
  'Expenses',
  'Price List',
  'Stock Write-Offs',
  'Remaining Stock',
  'Profit & Loss'
];
