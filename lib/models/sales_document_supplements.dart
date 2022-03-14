import '../source.dart';

part 'sales_document_supplements.freezed.dart';

enum PageActions { viewing, editing, adding }

@freezed
class SalesDocumentSupplements with _$SalesDocumentSupplements {
  const SalesDocumentSupplements._();

  const factory SalesDocumentSupplements({@Default([]) List<Document> documents,
    //for editing sales document
    required Document document,
    required DateTime date,
    @Default(true) bool isDateAsTitle,
    //for editing sales
    @Default('') String salesId,
    @Default('') String quantity,
    @Default('') String unitPrice,
    required Product product,
    //for both
    @Default(PageActions.viewing) PageActions action,
    @Default({}) Map<String, String?> errors}) = _SalesDocumentSupplements;

  factory SalesDocumentSupplements.empty() =>
      SalesDocumentSupplements(
          document: Document.empty(),
          product: const Product(),
          date: DateTime.now());

  double get parsedQuantity => double.parse(quantity);

  double get parsedUnitPrice => double.parse(unitPrice);

  bool get isEditing => action == PageActions.editing;

  bool get isViewing => action == PageActions.viewing;

  bool get isAdding => action == PageActions.adding;

}
