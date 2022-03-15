import '../source.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class SalesService extends ChangeNotifier {
  static const url = root + 'sales';
  var _hasChanges = false;
  var _salesList = <Sales>[];
  var _documents = <Document>[];

  List<Document> get getList => _documents;

  List<Sales> get getSalesList => _salesList;

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
        body: json.encode(document.toJson()), headers: headers);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);
    _documents.add(_document);
    clearSalesList();
    notifyListeners();
  }

  Future<void> editDocument(Document document) async {
    final response = await http.put(Uri.parse(url + '/${document.form.id}'),
        body: json.encode(document.toJson()), headers: headers);
    // log(response.body);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);

    final index = _documents.indexWhere((d) => d.form.id == document.form.id);
    _documents[index] = _document;
    clearSalesList();
    notifyListeners();
  }

  Future<void> deleteDocument(String id) async {
    await http.delete(Uri.parse(url + '/$id'));
    final index = _documents.indexWhere((e) => e.form.id == id);
    _documents.removeAt(index);
    notifyListeners();
  }

  void initDocument(Document document) {
    final salesList =
        document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
    _salesList = List.from(salesList);
  }

  addSalesTemporarily(Sales sales) {
    _salesList.add(sales);
    _hasChanges = true;
    notifyListeners();
  }

  editTemporarySales(Sales sales) {
    final index = _salesList.indexWhere((s) => s.id == sales.id);
    _salesList[index] = sales;
    _hasChanges = true;
    notifyListeners();
  }

  deleteTemporarySales(String salesId) {
    final index = _salesList.indexWhere((s) => s.id == salesId);
    _salesList.removeAt(index);
    _hasChanges = true;
    notifyListeners();
  }

  clearSalesList() {
    _salesList.clear();
    _hasChanges = false;
  }

  Document _getDocumentFromJson(var jsonDocument) {
    final form = DocumentForm.fromJson(jsonDocument);
    final salesList = <Sales>[];

    for (var item in jsonDocument['details']) {
      final sales = Sales.fromJson(item);
      salesList.add(sales);
    }
    return Document.sales(form, salesList);
  }
}
