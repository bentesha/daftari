import '../source.dart';

part 'write_off_supplements.freezed.dart';

@freezed
class WriteOffSupplements with _$WriteOffSupplements {
  const WriteOffSupplements._();

  const factory WriteOffSupplements(
      {@Default([]) List<Document> documents,
      //for editing sales document
      required Document document,
      required DateTime date,
      @Default(true) bool isDateAsTitle,
      //for editing write-offs
      @Default('') String quantity,
      @Default('') String writeOffId,
      required WriteOffTypes type,
      required Product product,
      //for both
      @Default(PageActions.viewing) PageActions action,
      @Default({}) Map<String, String?> errors}) = _WriteOffSupplements;

  factory WriteOffSupplements.empty() => WriteOffSupplements(
      document: Document.empty(),
      product: const Product(),
      type: WriteOffTypes.other,
      date: DateTime.now());

  List<WriteOff> get getWriteOffList {
    final writeOffList = document.maybeWhen(
        writeOffs: (_, __, w) => w, orElse: () => <WriteOff>[]);
    return writeOffList;
  }

  double get parsedQuantity => double.parse(quantity);
}
