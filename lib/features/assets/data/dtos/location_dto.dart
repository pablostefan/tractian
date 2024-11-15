import 'package:tractian/features/assets/domain/entities/location_entity.dart';

extension LocationDto on LocationEntity {
  static LocationEntity fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
