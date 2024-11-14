enum AssetType { component, asset, standalone }

enum AssetStatus { operating, alert }

class AssetEntity {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final AssetStatus? status;
  final String? gatewayId;
  final String? locationId;
  final AssetType type;

  AssetEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    String? status,
    this.gatewayId,
    this.locationId,
  })  : status = _mapStatus(status),
        type = _determineType(sensorType, locationId, parentId);

  bool get unliked => locationId == null && parentId == null;

  static AssetType _determineType(String? sensorType, String? locationId, String? parentId) {
    if (sensorType != null) {
      return AssetType.component;
    } else if (locationId != null && sensorType == null) {
      return AssetType.asset;
    } else if (parentId != null && sensorType == null) {
      return AssetType.asset;
    } else {
      return AssetType.standalone;
    }
  }

  static AssetStatus? _mapStatus(String? status) {
    switch (status) {
      case 'operating':
        return AssetStatus.operating;
      case 'alert':
        return AssetStatus.alert;
      default:
        return null;
    }
  }
}
