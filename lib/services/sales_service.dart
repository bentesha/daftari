import '../source.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class SalesService extends ChangeNotifier {
  static var _document = Document.empty();
  final _documents = <Document>[];

  Document get getCurrent => _document;
  List<Document> get getList => _documents;

  ///Gets all sales documents from the server
  Future<void> init() async {
    const url = root + 'sales?eager=[details.product]';
    final response = await http.get(Uri.parse(url), headers: headers);
    final documents = json.decode(response.body);

    for (var jsonDocument in documents) {
      final form = DocumentForm.fromJson(jsonDocument);
      final salesList = <Sales>[];

      for (var item in jsonDocument['details']) {
        final sales = Sales.fromJson(item);
        salesList.add(sales);
      }

      final document = Document.sales(form, salesList);
      _documents.add(document);
    }
  }

  Future<void> add(Document document) async {
    const url = root + 'sales';
    final response = await http.post(Uri.parse(url),
        body: json.encode(document.toJson()), headers: headers);
    log(response.body);
    _document = document;
    notifyListeners();
  }

  Future<void> edit(Document document) async {
    _document = document;
    notifyListeners();
  }
}
