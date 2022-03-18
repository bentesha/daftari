import '../source.dart';
import 'service_constants.dart';
import 'with_document_base_service.dart';

class WriteOffsService extends WithDocumentBaseService<WriteOff> {
  WriteOffsService()
      : super(
            url: root + 'stockWriteoff', documentType: DocumentType.writeOffs);
}
