import 'package:tractian/features/assets/domain/entities/base_entity.dart';

enum LocationType { location, subLocation }

class LocationEntity extends BaseEntity {
  final String? parentId;
  final LocationType type;

  LocationEntity({
    required super.id,
    required super.name,
    this.parentId,
  }) : type = _determineType(parentId);

  bool get unliked => parentId == null;

  static LocationType _determineType(String? parentId) {
    return parentId == null ? LocationType.location : LocationType.subLocation;
  }
}
