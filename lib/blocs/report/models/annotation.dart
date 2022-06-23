class Annotation {
  final String title, shortTitle, type;
  const Annotation(this.title, this.shortTitle, this.type);

  const Annotation.empty() : this('item', 'amount', '');

  factory Annotation.fromMap(Map<String, dynamic> rawMap) {
    return Annotation(rawMap['title'], rawMap['shortTitle'], rawMap['type']);
  }
}
