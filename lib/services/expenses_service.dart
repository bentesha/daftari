import '../source.dart';
import 'with_document_base_service.dart';

class ExpensesService extends WithDocumentBaseService<Expense> {
  ExpensesService()
      : super(url: '${root}expense', documentType: DocumentType.expenses);

  double get temporaryExpensesTotal {
    return getTemporaryList.fold<double>(
        0, (prev, current) => prev + current.amount);
  }
}
