class Group {
  final double total;
  final String title;
  final List<Data>? data;
  const Group(this.title, {this.data, this.total = 0});
}

class Data {
  final double total;
  final String title;
  const Data(this.title, {this.total = 0});
}
