import '../source.dart';

part 'write_off_supplements.freezed.dart';

@freezed
class WriteOffSupplements with _$WriteOffSupplements {
  const factory WriteOffSupplements({
    required List<Group> groups,
    required List<WriteOff> writeOffs,
    required Map<String, String?> errors,
    required String quantity,
    required Product product,
    required Group group,
    required String id,
  }) = _WriteOffSupplements;

  factory WriteOffSupplements.empty() {
    return WriteOffSupplements(
        groups: <Group>[],
        writeOffs: <WriteOff>[],
        errors: <String, String?>{},
        quantity: '',
        product: Product.empty(),
        group: Group.empty().copyWith(type: ''),
        id: '');
  }
}
