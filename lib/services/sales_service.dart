import '../source.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class SalesService extends ChangeNotifier {
  var _document = Document.empty();
  final _documents = <Document>[];

  List<Document> get getList => _documents;
  Document get getCurrent => _document;

  ///Gets all sales documents from the server
  Future<void> init() async {
    if (_documents.isNotEmpty) return;

    const url = root + 'sales?eager=[details.product]';
    final response = await http.get(Uri.parse(url), headers: headers);
    final documents = json.decode(response.body);

    for (var jsonDocument in documents) {
      final document = _getDocumentFromJson(jsonDocument);
      _documents.add(document);
    }
  }

  Future<void> add(Document document) async {
    const url = root + 'sales';
    final response = await http.post(Uri.parse(url),
        body: json.encode(document.toJson()), headers: headers);
    log(response.body);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);
    _documents.add(_document);
    notifyListeners();
  }

  Future<void> edit(Document document) async {
    const url = root + 'sales';
    final response = await http.put(Uri.parse(url),
        body: json.encode(document.toJson()), headers: headers);
    log(response.body);
    final jsonDocument = json.decode(response.body);
    final _document = _getDocumentFromJson(jsonDocument);

    final index = _documents.indexWhere((d) => d.form.id == document.form.id);
    _documents[index] = _document;
    notifyListeners();
  }

  initDocument(Document document)=> _document = document;

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
