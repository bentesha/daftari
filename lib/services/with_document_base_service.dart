import '../source.dart';
import '../errors/error_handler_mixin.dart';
import '../utils/extensions.dart/document_type.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

part 'with_document_base_service_type_handler.dart';

class WithDocumentBaseService<T> extends ChangeNotifier with ErrorHandler {
  final String url;
  final DocumentType documentType;
  WithDocumentBaseService({required this.url, required this.documentType});

  var _hasChanges = false;
  final _temporaryList = [];
  final _documents = <Document>[];
  var _current = Document.empty();

  List<Document> get getList => _documents;
  Document get getCurrent => _current;

  List<T> get getTemporaryList => _temporaryList.whereType<T>().toList();

  bool get hasChanges => _hasChanges;

  /// Gets all documents from the server
  Future<void> init() async {
    final getURL = _getGetURL();
    if (_documents.isNotEmpty) return;
    try {
      final results = await http.get(getURL) as List;
      if (results.isEmpty) return;

      final documentList =
          results.map((e) => _getDocumentFromJson<T>(e)).toList();
      _documents.addAll(documentList);
    } catch (e) {
      throw getError(e);
    }
  }

  Future<void> addDocument(Document document) async {
    try {
      final result =
          await http.post(url, jsonItem: document.toJson(documentType));
      final _document = _getDocumentFromJson<T>(result);
      _documents.add(_document);
      clearTemporaryList();
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  Future<void> editDocument(Document document) async {
    final id = document.form.id;
    try {
      final result =
          await http.put(url, id, jsonItem: document.toJson(documentType));
      final _document = _getDocumentFromJson<T>(result);
      final index = _documents.indexWhere((d) => d.form.id == id);
      _documents[index] = _document;
      clearTemporaryList();
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  Future<void> deleteDocument(String id) async {
    try {
      await http.delete(url, id);
      final index = _documents.indexWhere((e) => e.form.id == id);
      _documents.removeAt(index);
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  ///initializes the temporary list to store user edits, because they won't
  ///be directly sent to the server. When the user commits the changes, this list
  ///is used to create a document that will be sent to the server.
  ///If user discards changes, his data on the server is not messed up with.
  void initDocument(Document document) {
    final documentItemList = _initTemporaryList<T>(document);
    _temporaryList
      ..clear()
      ..addAll(documentItemList);
  }


  ///used mainly by the search bloc to update the current selected category or
  ///product. So that listeners can get it just by calling [salesService.getCurrent]
  ///or [expensesService.getCurrent]
  void updateCurrent(String id) {
    final index = _documents.indexWhere((e) => e.form.id == id);
    final document = _documents[index];
    _current = document;
    notifyListeners();
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

  String _getGetURL() {
    const params = 'eager=details.category';
    if (documentType.isExpenses) return '${root}expense?$params';
    return url;
  }
}
