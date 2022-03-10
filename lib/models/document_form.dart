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
      @JsonKey(name: 'date') required int timestamp}) = _DocumentForm;

  factory DocumentForm.empty() =>
      DocumentForm(timestamp: DateTime.now().microsecondsSinceEpoch);

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp);

  String get formattedDate => DateFormatter.convertToDMY(
      DateTime.fromMillisecondsSinceEpoch(timestamp));

  factory DocumentForm.fromJson(Map<String, dynamic> json) =>
      _$DocumentFormFromJson(json);
}
