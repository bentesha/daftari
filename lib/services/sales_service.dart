import '../source.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class SalesService extends ChangeNotifier {
  static const url = root + 'sales';
  var _salesList = <Sales>[];
  final _documents = <Document>[];

  List<Document> get getList => _documents;

  List<Sales> get getSalesList => _salesList;

  ///Gets all sales documents from the server
  Future<void> init() async {
    if (_documents.isNotEmpty) return;

    final response = await http.get(Uri.parse(url), headers: headers);
    final documents = json.decode(response.body);

    for (var jsonDocument in documents) {
      final document = _getDocumentFromJson(jsonDocument);
      _documents.add(document);
    }
  }

  Future<void> add(Document document) async {
    final response = await http.post(Uri.parse(url),
        body: json.encode(document.toJson()), headers: headers);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);
    _documents.add(_document);
    _salesList.clear();
    notifyListeners();
  }

  Future<void> edit(Document document) async {
    final response = await http.put(Uri.parse(url + '/${document.form.id}'),
        body: json.encode(document.toJson()), headers: headers);
    // log(response.body);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);

    final index = _documents.indexWhere((d) => d.form.id == document.form.id);
    _documents[index] = _document;
    _salesList.clear();
    notifyListeners();
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse(url + '/$id'));
    //log(response.body);
    final index = _salesList.indexWhere((e) => e.id == id);
    _salesList.removeAt(index);
    notifyListeners();
  }

  initDocument(Document document) => _salesList =
      document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);

  addSalesTemporarily(Sales sales) {
    _salesList.add(sales);
    notifyListeners();
  }

  editTemporarySales(Sales sales) {
    final index = _salesList.indexWhere((s) => s.id == sales.id);
    _salesList[index] = sales;
    notifyListeners();
  }

  deleteTemporarySales(String salesId) {
    final index = _salesList.indexWhere((s) => s.id == salesId);
    _salesList.removeAt(index);
    notifyListeners();
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
