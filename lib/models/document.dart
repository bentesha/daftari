import 'dart:html';

import '../source.dart';
import 'document_form.dart';

part 'document.freezed.dart';

@freezed
class Document with _$Document {
  const factory Document.sales(DocumentForm form, List<Sales> sales) = _Sales;
  const factory Document.purchases(DocumentForm form) = _Purchases;
  const factory Document.expenses(DocumentForm form) = _Expenses;
  const factory Document.writeOffs(DocumentForm form) = _WriteOffs;

  factory Document.empty() => Document.sales(DocumentForm.empty(), <Sales>[]);
}
