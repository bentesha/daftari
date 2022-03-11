import '../source.dart';

part 'sales_documents_pages_state.freezed.dart';

@freezed
class SalesDocumentsPagesState with _$SalesDocumentsPagesState {
  const factory SalesDocumentsPagesState.loading(SalesDocumentSupplements supplements) = _Loading;
  const factory SalesDocumentsPagesState.content(SalesDocumentSupplements supplements) = _Content;
  const factory SalesDocumentsPagesState.success(SalesDocumentSupplements supplements) = _Success;

  factory SalesDocumentsPagesState.initial() => SalesDocumentsPagesState.content(SalesDocumentSupplements.empty());
}