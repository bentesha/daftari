import '../source.dart';
import 'with_document_base_service.dart';

class PurchasesService extends WithDocumentBaseService<Purchase> {
  PurchasesService()
      : super(url: root + 'purchase', documentType: DocumentType.purchases);

  double get temporaryPurchasesTotal {
    return getTemporaryList.fold<double>(
        0, (prev, current) => prev + current.calcTotal);
  }
}
