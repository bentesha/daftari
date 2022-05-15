part of 'with_document_base_service.dart';

List<T> getItemListFrom<T>(Document document) {
  late final List itemList;

  switch (T) {
    case Sales:
      itemList = document.maybeWhen(
          sales: (_, salesList) => salesList, orElse: () => <Sales>[]);
      break;
    case Purchase:
      itemList = document.maybeWhen(
          purchases: (_, purchaseList) => purchaseList,
          orElse: () => <Purchase>[]);
      break;
    case Expense:
      itemList = document.maybeWhen(
          expenses: (_, expenseList) => expenseList, orElse: () => <Expense>[]);
      break;
    case WriteOff:
      itemList = document.maybeWhen(
          writeOffs: (_, __, writeOffList) => writeOffList,
          orElse: () => <WriteOff>[]);
      break;
  }
  return itemList.whereType<T>().toList();
}

Document _getDocumentFromJson<T>(var jsonDocument) {
  log(jsonDocument.toString());
  final details = jsonDocument['details'] as List;
  final itemList =
      details.map((e) => _getItemFromJson<T>(e)).whereType<T>().toList();

  return _getSpecificTypeDocument<T>(jsonDocument, itemList);
}

dynamic _getItemFromJson<T>(var jsonItem) {
  switch (T) {
    case Sales:
      return Sales.fromJson(jsonItem);
    case Purchase:
      return Purchase.fromJson(jsonItem);
    case Expense:
      return Expense.fromJson(jsonItem);
    case WriteOff:
      return WriteOff.fromJson(jsonItem);
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
