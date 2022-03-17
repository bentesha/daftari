import '../source.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class WithDocumentBaseService<T> extends ChangeNotifier {
  final String url;
  final DocumentType documentType;
  WithDocumentBaseService({required this.url, required this.documentType});

  var _hasChanges = false;
  var _temporaryList = [];
  var _documents = <Document>[];

  List<Document> get getList => _documents;

  List<T> get getTemporaryList => _temporaryList.whereType<T>().toList();

  bool get hasChanges => _hasChanges;

  ///Gets all sales documents from the server
  Future<void> init() async {
    if (_documents.isNotEmpty) return;
    final response = await http.get(Uri.parse(url), headers: headers);
    final jsonDocuments = json.decode(response.body);

    final documents = <Document>[];

    for (var jsonDocument in jsonDocuments) {
      final document = _getDocumentFromJson(jsonDocument);
      documents.add(document);
    }
    _documents = documents;
  }

  Future<void> addDocument(Document document) async {
    final response = await http.post(Uri.parse(url),
        body: json.encode(document.toJson(documentType)), headers: headers);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);
    _documents.add(_document);
    clearTemporaryList();
    notifyListeners();
  }

  Future<void> editDocument(Document document) async {
    final response = await http.put(Uri.parse(url + '/${document.form.id}'),
        body: json.encode(document.toJson(documentType)), headers: headers);
    // log(response.body);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);

    final index = _documents.indexWhere((d) => d.form.id == document.form.id);
    _documents[index] = _document;
    clearTemporaryList();
    notifyListeners();
  }

  Future<void> deleteDocument(String id) async {
    await http.delete(Uri.parse(url + '/$id'));
    final index = _documents.indexWhere((e) => e.form.id == id);
    _documents.removeAt(index);
    notifyListeners();
  }

  void initDocument(Document document) {
    late final List itemList;

    switch (T) {
      case Sales:
        itemList =
            document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
        break;
      case Purchases:
        itemList = document.maybeWhen(
            purchases: (_, p) => p, orElse: () => <Purchases>[]);
        break;
      case Expense:
        itemList = document.maybeWhen(
            expenses: (_, e) => e, orElse: () => <Expense>[]);
        break;
    }

    _temporaryList = List.from(itemList);
  }

  addItemTemporarily(var item) {
    _temporaryList.add(item);
    _hasChanges = true;
    notifyListeners();
  }

  editTemporaryItem(var item) {
    final index = _temporaryList.indexWhere((s) => s.id == item.id);
    _temporaryList[index] = item;
    _hasChanges = true;
    notifyListeners();
  }

  deleteTemporaryItem(String id) {
    final index = _temporaryList.indexWhere((s) => s.id == id);
    _temporaryList.removeAt(index);
    _hasChanges = true;
    notifyListeners();
  }

  clearTemporaryList() {
    _temporaryList.clear();
    _hasChanges = false;
  }

  Document _getDocumentFromJson(var jsonDocument) {
    final form = DocumentForm.fromJson(jsonDocument);
    final itemList = <T>[];

    for (var json in jsonDocument['details']) {
      final item = _getItemFromJson(json);
      itemList.add(item);
    }
    return _getSpecificTypeDocument(form, itemList);
  }

  dynamic _getItemFromJson(var json) {
    switch (T) {
      case Sales:
        return Sales.fromJson(json);
      case Purchases:
        return Purchases.fromJson(json);
      case Expense:
        return Expense.fromJson(json);
    }
  }

  Document _getSpecificTypeDocument(DocumentForm form, List<T> itemList) {
    switch (T) {
      case Sales:
        final salesList = itemList.whereType<Sales>().toList();
        return Document.sales(form, salesList);
      case Purchases:
        final purchaseList = itemList.whereType<Purchases>().toList();
        return Document.purchases(form, purchaseList);
      case Expense:
        final purchaseList = itemList.whereType<Expense>().toList();
        return Document.expenses(form, purchaseList);
    }
    return Document.empty();
  }
}
