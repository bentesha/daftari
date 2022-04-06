import '../source.dart';
import '../widgets/app_data_table.dart';
import '../widgets/breakdown_datatable.dart';

class BreakDownPage extends StatefulWidget {
  const BreakDownPage({Key? key}) : super(key: key);

  @override
  State<BreakDownPage> createState() => _BreakDownPageState();
}

class _BreakDownPageState extends State<BreakDownPage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppText('Breakdown Page',
              size: 18.dw, color: AppColors.onPrimary)),
      body: const BreakDownDataTable()
     
    );
  }
}
