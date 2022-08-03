import '../source.dart';

part 'sales_document_supplements.freezed.dart';

enum PageActions { viewing, editing, adding }

extension PageActionsExtension on PageActions {
  bool get isViewing => this == PageActions.viewing;
  bool get isEditing => this == PageActions.editing;
  bool get isAdding => this == PageActions.adding;
}

@freezed
class SalesDocumentSupplements with _$SalesDocumentSupplements {
  const SalesDocumentSupplements._();

  const factory SalesDocumentSupplements(
      {@Default([]) List<Document> documents,
      //for editing sales document
      required Document document,
      required DateTime date,
      @Default(true) bool isDateAsTitle,
      //for editing sales
      @Default('') String salesId,
      @Default('1') String quantity,
      @Default('') String unitPrice,
      required Product product,
      //for both
      @Default(PageActions.viewing) PageActions action,
      @Default({}) Map<String, String?> errors}) = _SalesDocumentSupplements;

  factory SalesDocumentSupplements.empty() => SalesDocumentSupplements(
      document: Document.empty(),
      product: const Product(),
      date: DateTime.now());

  List<Sales> get getSalesList {
    final list =
        document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
    //list is a unmodified list, doing this b'se list are mutable
    final salesList = List.from(list).whereType<Sales>().toList();
    salesList.sort((a, b) => a.sort.compareTo(b.sort));
    return salesList;
  }

  double get parsedQuantity => double.parse(quantity);

  double get parsedUnitPrice => double.parse(unitPrice);
}
