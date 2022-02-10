import '../source.dart';

part 'group_pages_state.freezed.dart';

@freezed
class GroupPagesState with _$GroupPagesState {
  const factory GroupPagesState.loading(GroupSupplements supplements) = _Loading;
  const factory GroupPagesState.content(GroupSupplements supplements) = _Content;
  const factory GroupPagesState.success(GroupSupplements supplements) = _Success;

  factory GroupPagesState.initial() => GroupPagesState.content(GroupSupplements.empty());
}
