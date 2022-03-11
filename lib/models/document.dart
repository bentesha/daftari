import '../source.dart';

part 'document.freezed.dart';

@freezed
class Document with _$Document {
  const Document._();

  const factory Document.sales(DocumentForm form, List<Sales> sales) = _Sales;
  const factory Document.purchases(DocumentForm form) = _Purchases;
  const factory Document.expenses(DocumentForm form) = _Expenses;
  const factory Document.writeOffs(DocumentForm form) = _WriteOffs;

  factory Document.empty() => const Document.sales(DocumentForm(), <Sales>[]);

  Map<String, dynamic> toJson() {
    final jsonDocument = form.convertToJson();
    final details = maybeWhen(sales: (_, sales) => sales, orElse: () => []);
    jsonDocument['details'] = details.map((e) => e.convertToJson()).toList();
    log(jsonDocument.toString());
    return jsonDocument;
  }
}
