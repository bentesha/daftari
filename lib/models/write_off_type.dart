class WriteOffType {
  final String name;
  WriteOffType._(this.name);

  factory WriteOffType.spoilage() => WriteOffType._('Spoilage');
  factory WriteOffType.expiry() => WriteOffType._('Expiry');
  factory WriteOffType.theft() => WriteOffType._('Theft');
}
