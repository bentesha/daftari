import '../source.dart';

part 'sales_documents_pages_state.freezed.dart';

@freezed
class SalesDocumentsPageState with _$SalesDocumentsPageState {
  const factory SalesDocumentsPageState.loading(SalesDocumentSupplements supplements) = _Loading;
  const factory SalesDocumentsPageState.content(SalesDocumentSupplements supplements) = _Content;
  const factory SalesDocumentsPageState.success(SalesDocumentSupplements supplements) = _Success;
  const factory SalesDocumentsPageState.failed(SalesDocumentSupplements supplements,
      {String? message, @Default(false) bool showOnPage}) = _Failed;

  factory SalesDocumentsPageState.initial() => SalesDocumentsPageState.content(SalesDocumentSupplements.empty());
}
