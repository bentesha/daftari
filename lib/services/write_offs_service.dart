import '../source.dart';
import 'with_document_base_service.dart';

class WriteOffsService extends WithDocumentBaseService<WriteOff> {
  WriteOffsService()
      : super(
            url: root + 'stockWriteoff', documentType: DocumentType.writeOffs);

  double get temporaryWriteOffsTotal {
    return getTemporaryList.fold<double>(
        0, (prev, current) => prev + current.calcTotal);
  }

  // an override to make sure every writeoff document has total amount lost, as it does not
  // comes directly from the server
  @override
  List<Document> get getList {
    final writeOffsDocuments = <Document>[];
    for (var e in super.getList) {
      final total = e.maybeWhen(
          writeOffs: (_, __, data) =>
              data.fold<double>(0, (prev, current) => prev + current.calcTotal),
          orElse: () => 0.0);
      final form = e.form.copyWith(total: total);
      final type =
          e.maybeWhen(writeOffs: (_, type, __) => type, orElse: () => null);
      final list =
          e.maybeWhen(writeOffs: (_, __, data) => data, orElse: () => null);
      writeOffsDocuments.add(Document.writeOffs(form, type!, list!));
    }
    return writeOffsDocuments;
  }
}
