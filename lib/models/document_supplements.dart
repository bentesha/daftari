import '../source.dart';

part 'document_supplements.freezed.dart';

@freezed
class DocumentSupplements with _$DocumentSupplements {
  const factory DocumentSupplements({
    required Document document,
    required DateTime date,
    required String id,
    required String title,
    required Map<String, String?> errors,
    required Map<String, double> groupAmounts,
    required bool isDateAsTitle,
  }) = _GroupPageSupplement;

  factory DocumentSupplements.empty() => DocumentSupplements(
      document: Document.empty(),
      id: '',
      title: '',
      date: DateTime.now(),
      isDateAsTitle: true,
      groupAmounts: {},
      errors: {});
}
