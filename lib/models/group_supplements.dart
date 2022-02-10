import '../source.dart';

part 'group_supplements.freezed.dart';

@freezed
class GroupSupplements with _$GroupSupplements {
  const factory GroupSupplements({
    required List<Group> groupList,
    required DateTime date,
    required String id,
    required String title,
    required Map<String, String?> errors,
   required bool isDateAsTitle,
  }) = _GroupPageSupplement;

  factory GroupSupplements.empty() => GroupSupplements(
      groupList: <Group>[],
      id: '',
      date: DateTime.now(),
      title: '',
      isDateAsTitle: true,
      errors: {});
}
