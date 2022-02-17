import '../source.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PageAppBar(title: 'Reports'),
      body: Center(child: AppText('REPORTS')),
    );
  }
}
