import '../source.dart';
import 'constants.dart';
import 'with_document_base_service.dart';

class PurchasesService extends WithDocumentBaseService<Purchases> {
  PurchasesService()
      : super(url: root + 'purchase', documentType: DocumentType.purchases);
}
