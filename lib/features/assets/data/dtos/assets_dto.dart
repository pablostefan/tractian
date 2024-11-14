import 'package:tractian/features/assets/domain/entities/asset_entity.dart';

extension AssetsDto on AssetEntity {
  static AssetEntity fromJson(Map<String, dynamic> json) {
    return AssetEntity(
      id: json['id'],
      name: json['name'],
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gatewayId': gatewayId,
      'locationId': locationId,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
    };
  }
}