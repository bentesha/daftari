import '../source.dart';

class WriteOffsTypesService extends ChangeNotifier {
  static var _selectedType = WriteOffType.spoilage();

  List<WriteOffType> get getWriteOffTypesList => kWriteOffTypesList;

  WriteOffType get getSelectedType => _selectedType;

  void updateType(WriteOffType type) {
    _selectedType = type;
    notifyListeners();
  }

  static final kWriteOffTypesList = <WriteOffType>[
    WriteOffType.spoilage(),
    WriteOffType.expiry(),
    WriteOffType.theft()
  ];
}
