import '../source.dart';
import 'document_form.dart';

part 'write_off_supplements.freezed.dart';

@freezed
class WriteOffSupplements with _$WriteOffSupplements {
  const factory WriteOffSupplements({
    required List<Document> groups,
    required List<WriteOff> writeOffs,
    required Map<String, String?> errors,
    required String quantity,
    required Product product,
    required Document group,
    required DateTime date,
    required String id,
  }) = _WriteOffSupplements;

  factory WriteOffSupplements.empty() {
    return WriteOffSupplements(
        groups: <Document>[],
        writeOffs: <WriteOff>[],
        errors: <String, String?>{},
        date: DateTime.now(),
        quantity: '',
        product: const Product(),
        group: const Document.writeOffs(DocumentForm()),
        id: '');
  }
}
