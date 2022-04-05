import '../source.dart';

class AppDataTable extends StatelessWidget {
  const AppDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 680.dh,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: _columns, rows: _rows)),
      ),
    );
  }

  List<DataColumn> get _columns {
    return labels.map((e) => DataColumn(label: Text(e))).toList();
  }

  List<DataRow> get _rows {
    final playersData =
        teamBatters.map((e) => DataRow(cells: _buildDataCells(e))).toList();

    final teamData = DataRow(cells: [
      _buildTeamDataCell('TEAM'),
      _buildTeamDataCell(teamBatterDetails.ab),
      _buildTeamDataCell(teamBatterDetails.r),
      _buildTeamDataCell(teamBatterDetails.h),
      _buildTeamDataCell(teamBatterDetails.rbi),
      _buildTeamDataCell(teamBatterDetails.bb),
      _buildTeamDataCell(teamBatterDetails.avg),
      _buildTeamDataCell(teamBatterDetails.obp),
      _buildTeamDataCell(teamBatterDetails.slg),
    ]);

    return [
      ...playersData,
      ...[teamData]
    ];
  }

  _buildDataCells(Expense batter) {
    return [
      _buildDataCell(batter.name, true, batter.position),
      _buildDataCell(batter.details.ab),
      _buildDataCell(batter.details.r),
      _buildDataCell(batter.details.h),
      _buildDataCell(batter.details.rbi),
      _buildDataCell(batter.details.bb),
      _buildDataCell(batter.details.avg),
      _buildDataCell(batter.details.obp),
      _buildDataCell(batter.details.slg),
    ];
  }

  DataCell _buildDataCell(String value,
      [bool isBatterName = false, String? position]) {
    return DataCell(isBatterName
        ? Row(children: [Text(value), Text('[$position]')])
        : Text(value));
  }

  DataCell _buildTeamDataCell(String value) {
    return DataCell(
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)));
  }

  static const labels = [
    'BATTER',
    'AB',
    'R',
    'H',
    'RBI',
    'BB',
    'AVG',
    'OBP',
    'SLG'
  ];
}
