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
    required String id,
  }) = _WriteOffSupplements;

  factory WriteOffSupplements.empty() {
    return WriteOffSupplements(
        groups: <Document>[],
        writeOffs: <WriteOff>[],
        errors: <String, String?>{},
        quantity: '',
        product: Product.empty(),
        group: Document.writeOffs(DocumentForm.empty()),
        id: '');
  }
}
