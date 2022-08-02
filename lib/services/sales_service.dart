import '../source.dart';
import 'with_document_base_service.dart';

class SalesService extends WithDocumentBaseService<Sales> {
  SalesService() : super(url: root + 'sales', documentType: DocumentType.sales);

  double get temporarySalesTotal {
    return getTemporaryList.fold<double>(
        0, (prev, current) => prev + current.calcTotal);
  }
}
