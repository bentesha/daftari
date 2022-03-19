import 'dart:async';
import 'with_no_document_base_service.dart';
import '../source.dart';

class OpeningStockItemsService extends WithNoDocumentBaseService<OpeningStockItem> {
  ///Gets all opening-stock-items from the server
  Future<void> init() async => await super.getAll();
}
