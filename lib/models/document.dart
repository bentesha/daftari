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
    final json = form.toJson();
    final details = maybeWhen(sales: (_, sales) => sales, orElse: () => []);
    json['details'] = details.map((e) => e.toJson()).toList();
    return json;
  }
}
