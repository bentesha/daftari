import '../source.dart';

part 'group_supplements.freezed.dart';

@freezed
class GroupSupplements with _$GroupSupplements {
  const factory GroupSupplements({
    required List<Group> groupList,
    required List<Record> recordList,
    required DateTime date,
    required String id,
    String? title,
    required Map<String, String?> errors,
    required Map<String, double> groupAmounts,
    required bool isDateAsTitle,
  }) = _GroupPageSupplement;

  factory GroupSupplements.empty() => GroupSupplements(
      groupList: <Group>[],
      recordList: <Record>[],
      id: '',
      date: DateTime.now(),
      isDateAsTitle: true,
      groupAmounts: {},
      errors: {});
}
