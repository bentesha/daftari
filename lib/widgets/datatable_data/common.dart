class Group {
  final double total;
  final String title;
  final List<Data>? data;
  const Group(this.title, {this.data, this.total = 0});

  Group copyWithTotal(double newTotal) {
    return Group(title, data: data, total: newTotal);
  }
}

class Data {
  final double total;
  final String title;
  const Data(this.title, {this.total = 0});

  Data copyWithTotal(double newTotal) {
    return Data(title, total: newTotal);
  }
}
