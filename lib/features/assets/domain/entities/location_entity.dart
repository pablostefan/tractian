enum LocationType { location, subLocation }

class LocationEntity {
  final String id;
  final String name;
  final String? parentId;
  final LocationType type;

  LocationEntity({
    required this.id,
    required this.name,
    this.parentId,
  }) : type = _determineType(parentId);

  bool get unliked => parentId == null;

  static LocationType _determineType(String? parentId) {
    return parentId == null ? LocationType.location : LocationType.subLocation;
  }
}
