enum WriteOffTypes { stolen, damaged, expired, other }

extension WriteOffTypesString on WriteOffTypes {
  String get string {
    switch (this) {
      case WriteOffTypes.stolen:
        return 'Stolen';
      case WriteOffTypes.damaged:
        return 'Damaged';
      case WriteOffTypes.expired:
        return 'Expired';
      case WriteOffTypes.other:
        return 'Other';
    }
  }
}
