part of 'with_document_base_service.dart';

List<T> _initTemporaryList<T>(Document document) {
  late final List itemList;

  switch (T) {
    case Sales:
      itemList =
          document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
      break;
    case Purchase:
      itemList = document.maybeWhen(
          purchases: (_, p) => p, orElse: () => <Purchase>[]);
      break;
    case Expense:
      itemList =
          document.maybeWhen(expenses: (_, e) => e, orElse: () => <Expense>[]);
      break;
    case WriteOff:
      itemList = document.maybeWhen(
          writeOffs: (_, __, w) => w, orElse: () => <WriteOff>[]);
      break;
  }
  return itemList.whereType<T>().toList();
}

Document _getDocumentFromJson<T>(var jsonDocument) {
  final details = jsonDocument['details'] as List;
  final itemList =
      details.map((e) => _getItemFromJson(e)).whereType<T>().toList();

  return _getSpecificTypeDocument(jsonDocument, itemList);
}

dynamic _getItemFromJson<T>(var json) {
  switch (T) {
    case Sales:
      return Sales.fromJson(json);
    case Purchase:
      return Purchase.fromJson(json);
    case Expense:
      return Expense.fromJson(json);
    case WriteOff:
      return WriteOff.fromJson(json);
  }
}

Document _getSpecificTypeDocument<T>(var jsonDocument, List<T> itemList) {
  final form = DocumentForm.fromJson(jsonDocument);

  switch (T) {
    case Sales:
      final salesList = itemList.whereType<Sales>().toList();
      return Document.sales(form, salesList);
    case Purchase:
      final purchaseList = itemList.whereType<Purchase>().toList();
      return Document.purchases(form, purchaseList);
    case Expense:
      final expenseList = itemList.whereType<Expense>().toList();
      return Document.expenses(form, expenseList);
    case WriteOff:
      final writeOffList = itemList.whereType<WriteOff>().toList();
      final type = _getWriteOffTypeFrom(jsonDocument['type']);
      return Document.writeOffs(form, type, writeOffList);
  }
  return Document.empty();
}

WriteOffTypes _getWriteOffTypeFrom(String type) {
  if (type == 'Stolen') return WriteOffTypes.stolen;
  if (type == 'Damaged') return WriteOffTypes.damaged;
  if (type == 'Expired') return WriteOffTypes.expired;
  return WriteOffTypes.other;
}
