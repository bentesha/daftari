// ignore_for_file: invalid_annotation_target
import '../source.dart';

part 'document_form.freezed.dart';
part 'document_form.g.dart';

@freezed
class DocumentForm with _$DocumentForm {
  const DocumentForm._();

  const factory DocumentForm(
      {@Default('') String id,
      @Default('') String title,
      String? description,
      @Default(0.0) double total,
      @Default('') String date}) = _DocumentForm;

  factory DocumentForm.fromJson(Map<String, dynamic> json) =>
      _$DocumentFormFromJson(json);

  DateTime get dateTime => DateTime.parse(date);

  String get formattedTotal => Utils.convertToMoneyFormat(total);
}
