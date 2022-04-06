import '../source.dart';
import 'with_document_base_service.dart';

class ExpensesService extends WithDocumentBaseService<Expense> {
  static const params = 'eager=details.category';
  ExpensesService()
      : super(
            url: '${root}expense?$params', documentType: DocumentType.expenses);
}
