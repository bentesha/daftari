import '../source.dart';

class WriteOffsTypesService extends TypesService<WriteOffType> {
  WriteOffsTypesService() : super(kWriteOffTypesList);

  static final kWriteOffTypesList = <WriteOffType>[
    WriteOffType.spoilage(),
    WriteOffType.expiry(),
    WriteOffType.theft()
  ];
}
