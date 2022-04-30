import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/widgets/app_datatable.dart';
import 'package:inventory_management/widgets/breakdown_datatable.dart';
import 'package:inventory_management/widgets/type_selector_dialog.dart';
import '../source.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  var reportType = 'Sales';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PageAppBar(
          title: '$reportType Report',
          actionCallbacks: [_showTypeSelectorDialog, () {}],
          actionIcons: const [
            FontAwesomeIcons.retweet,
            Icons.filter_alt_outlined
          ],
        ),
        body: Column(
          children: const [
            Expanded(child: AppDataTable()),
          ],
        ));
  }

  _showTypeSelectorDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return TypeSelectorDialog(
              onSelected: (selected) {
                reportType = selected;
                setState(() {});
              },
              currentType: reportType,
              title: 'Reports');
        });
  }
}
