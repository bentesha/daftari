import '../source.dart';

part 'group_supplements.freezed.dart';

@freezed
class GroupSupplements with _$GroupSupplements {
  const GroupSupplements._();

  const factory GroupSupplements({
    required List<Group> groupList,
    required List<Record> recordList,
    required DateTime date,
    required String id,
    required String title,
    required Map<String, String?> errors,
    required Map<String, double> groupAmounts,
    required bool isDateAsTitle,
    required bool canUseDateAsTitle,
  }) = _GroupPageSupplement;

  factory GroupSupplements.empty() => GroupSupplements(
      groupList: <Group>[],
      recordList: <Record>[],
      id: '',
      title: '',
      date: DateTime.now(),
      isDateAsTitle: true,
      groupAmounts: {},
      canUseDateAsTitle: true,
      errors: {});

  List<Record> get getSpecificGroupRecords =>
      recordList.where((e) => e.groupId == id).toList();
}
