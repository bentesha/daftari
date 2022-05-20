import '../source.dart';
import '../errors/error_handler_mixin.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

part 'with_document_base_service_type_handler.dart';

class WithDocumentBaseService<T> extends ChangeNotifier with ErrorHandler {
  final String url;
  final DocumentType documentType;
  WithDocumentBaseService({required this.url, required this.documentType});

  var _hasChanges = false;
  final _temporaryItemList = [];
  final _documents = <Document>[];

  var _current = Document.empty();
  final _temporaryDocs = <Document>[];

  Document get getCurrent => _current;
  List<Document> get getList => _documents;
  List<Document> get getTemporaryDocList => _temporaryDocs;
  List<T> get getTemporaryList => _temporaryItemList.whereType<T>().toList();

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

  Future<void> editDocument(Document document,
      [bool isFromQuickActions = false]) async {
    var doc = document;
    final id = doc.form.id;
    try {
      log(_isEditingFromQuickActions.toString());
      if (isFromQuickActions && !_isEditingFromQuickActions) {
        final _document = document.copyWith(form: _current.form);
        await addDocument(_document);
        return;
      }
      if (isFromQuickActions && _isEditingFromQuickActions) {
        final itemList = getItemListFrom<T>(doc);
        final index = _documents.indexWhere((e) => e.form.id == doc.form.id);
        if (index == -1) throw 'not found, handle this';
        final anotherList = getItemListFrom<T>(_documents[index]);
        final list = [...itemList, ...anotherList];
        doc = _getSpecificTypeDocument<T>(doc.form.toJson(), list);
      }
      final result =
          await http.put(url, id, jsonItem: doc.toJson(documentType));
      final _document = _getDocumentFromJson<T>(result);
      final index = _documents.indexWhere((d) => d.form.id == id);
      _documents[index] = _document;
      clearTemporaryList();
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  bool get _isEditingFromQuickActions {
    final index =
        _documents.indexWhere((doc) => doc.form.id == _current.form.id);
    return index != -1;
  }

  /// saved locally here, but not in the server. Added when the document is
  /// from the search-page
  void saveTemporaryDocument(Document document) {
    _current = document;
    _temporaryDocs.add(_current);
    notifyListeners();
  }

  /// removing the temporary document, called when the search page is popped
  void disposeTemporaryDocument() {
    _temporaryDocs.clear();
    notifyListeners();
  }

  void updateCurrent(Document document) => _current = document;

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

  /// initializes the temporary list to store user edits, because they won't
  /// be directly sent to the server. When the user commits the changes, this list
  /// is used to create a document that will be sent to the server.
  /// If user discards changes, his data on the server is not messed up with.
  void initDocument(Document document) {
    final documentItemList = getItemListFrom<T>(document);
    _temporaryItemList
      ..clear()
      ..addAll(documentItemList);
  }

  addItemTemporarily(var item) {
    _temporaryItemList.add(item);
    _hasChanges = true;
    notifyListeners();
  }

  editTemporaryItem(var item) {
    final index = _temporaryItemList.indexWhere((s) => s.id == item.id);
    _temporaryItemList[index] = item;
    _hasChanges = true;
    notifyListeners();
  }

  deleteTemporaryItem(String id) {
    final index = _temporaryItemList.indexWhere((s) => s.id == id);
    _temporaryItemList.removeAt(index);
    _hasChanges = true;
    notifyListeners();
  }

  clearTemporaryList() {
    _temporaryDocs.clear();
    _temporaryItemList.clear();
    _hasChanges = false;
  }

  String _getGetURL() {
    const params = 'eager=details.category';
    if (documentType.isExpenses) return '${root}expense?$params';
    return url;
  }
}
