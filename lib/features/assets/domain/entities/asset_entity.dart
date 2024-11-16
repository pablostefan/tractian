import 'package:tractian/features/assets/domain/entities/enums/componente_type.dart';
import 'package:tractian/features/assets/domain/entities/tree_component.dart';

class AssetEntity extends TreeComponent {
  final String? parentId;
  final String? sensorId;
  final String? gatewayId;
  final String? locationId;

  AssetEntity({
    required super.id,
    required super.name,
    super.sensorType,
    super.status,
    this.parentId,
    this.sensorId,
    this.gatewayId,
    this.locationId,
  }) : super(type: ComponentType.fromSensorType(sensorType));

  bool get unliked => locationId == null && parentId == null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
