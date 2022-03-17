import '../source.dart';

part 'purchases_pages_supplements.freezed.dart';

@freezed
class PurchasesPagesSupplements with _$PurchasesPagesSupplements {
   const PurchasesPagesSupplements._();

  const factory PurchasesPagesSupplements({@Default([]) List<Document> documents,
    //for editing sales document
    required Document document,
    required DateTime date,
    @Default(true) bool isDateAsTitle,
    //for editing sales
    @Default('') String purchasesId,
    @Default('') String quantity,
    @Default('') String unitPrice,
    required Product product,
    //for both
    @Default(PageActions.viewing) PageActions action,
    @Default({}) Map<String, String?> errors}) = _PurchasesPagesSupplements;

  factory PurchasesPagesSupplements.empty() =>
      PurchasesPagesSupplements(
          document: Document.empty(),
          product: const Product(),
          date: DateTime.now());

  List<Purchase> get getPurchaseList {
    final purchaseList =
    document.maybeWhen(purchases: (_, s) => s, orElse: () => <Purchase>[]);
    purchaseList.sort((a,b)=>a.sort.compareTo(b.sort));
    return purchaseList;
  }

  double get parsedQuantity => double.parse(quantity);

  double get parsedUnitPrice => double.parse(unitPrice);
}
