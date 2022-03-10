import '../source.dart';

part 'sales_documents_pages_state.freezed.dart';

@freezed
class SalesDocumentsPagesState with _$SalesDocumentsPagesState {
  const factory SalesDocumentsPagesState.loading(DocumentSupplements supplements) = _Loading;
  const factory SalesDocumentsPagesState.content(DocumentSupplements supplements) = _Content;
  const factory SalesDocumentsPagesState.success(DocumentSupplements supplements) = _Success;

  factory SalesDocumentsPagesState.initial() => SalesDocumentsPagesState.content(DocumentSupplements.empty());
}
