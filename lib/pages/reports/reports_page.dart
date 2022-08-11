import 'package:inventory_management/source.dart';

class ReportsSelectorPage extends StatelessWidget {
  const ReportsSelectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Reports")),
        body: ListView.separated(
          itemCount: ReportType.values.length,
          separatorBuilder: (_, __) => const AppDivider.zeroMargin(),
          itemBuilder: (_, index) {
            return ListTile(
                onTap: () =>
                    push(ReportPage(reportType: ReportType.values[index])),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                title: Text(ReportType.values[index].string,
                    style: const TextStyle(fontSize: 15)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18));
          },
        ));
  }
}
