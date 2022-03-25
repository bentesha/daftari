import '../source.dart';
import 'with_document_base_service.dart';

class PurchasesService extends WithDocumentBaseService<Purchase> {
  PurchasesService()
      : super(url: root + 'purchase', documentType: DocumentType.purchases);
}
