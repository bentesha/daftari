class Annotation {
  final String title, shortTitle, type;
  const Annotation(this.title, this.shortTitle, this.type);

  Annotation.empty() : this('', '', '');

  factory Annotation.fromMap(Map<String, dynamic> rawMap) {
    return Annotation(rawMap['title'], rawMap['shortTitle'], rawMap['type']);
  }
}
