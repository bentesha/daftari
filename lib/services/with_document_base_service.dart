import '../source.dart';
import '../utils/error_handler_mixin.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

part 'with_document_base_service_type_handler.dart';

class WithDocumentBaseService<T> extends ChangeNotifier with ErrorHandler {
  final String url;
  final DocumentType documentType;
  WithDocumentBaseService({required this.url, required this.documentType});

  var _hasChanges = false;
  final _temporaryList = [];
  final _documents = <Document>[];

  List<Document> get getList => _documents;

  List<T> get getTemporaryList => _temporaryList.whereType<T>().toList();

  bool get hasChanges => _hasChanges;

  ///Gets all documents from the server
  Future<void> init() async {
    if (_documents.isNotEmpty) return;
    try {
      final results = await http.get(url) as List;
      final documentList = results.map((e) => _getDocumentFromJson(e)).toList();
      _documents.addAll(documentList);
    } catch (e) {
      throw getError(e);
    }
  }

  Future<void> addDocument(Document document) async {
    try {
      final result = await http.post(url, json: document.toJson(documentType));
      final _document = _getDocumentFromJson(result);
      _documents.add(_document);
      clearTemporaryList();
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  Future<void> editDocument(Document document) async {
    try {
      final documentId = document.form.id;
      final result =
          await http.put(url, documentId, json: document.toJson(documentType));
      final _document = _getDocumentFromJson(result);
      final index = _documents.indexWhere((d) => d.form.id == documentId);
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
  ///is used to form a document that will be sent to the server.
  ///If user discards changes, his data on the server is not messed up with.
  void initDocument(Document document) {
    final documentItemList = _initTemporaryList(document);
    _temporaryList
      ..clear()
      ..addAll(documentItemList);
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
}
