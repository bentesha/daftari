import '../source.dart';

part 'sales_document_supplements.freezed.dart';

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
    @Default({}) Map<String, String?> errors}) = _SalesDocumentSupplements;

  factory SalesDocumentSupplements.empty() =>
      SalesDocumentSupplements(
          document: Document.empty(),
          product: Product.empty(),
          date: DateTime.now());

  double get parsedQuantity => double.parse(quantity);

  double get parsedUnitPrice => double.parse(unitPrice);
}
