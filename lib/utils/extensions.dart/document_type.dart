import 'package:inventory_management/models/document.dart';

extension DocumentTypeExtension on DocumentType {
  bool get isSales => DocumentType.sales == this;
  bool get isExpenses => DocumentType.expenses == this;
  bool get isPurchases => DocumentType.purchases == this;
  bool get isWriteOffs => DocumentType.writeOffs == this;
}
