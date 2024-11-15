import 'package:tractian/features/assets/domain/entities/enums/assets_status.dart';
import 'package:tractian/features/assets/domain/entities/enums/componente_type.dart';
import 'package:tractian/features/assets/domain/entities/enums/senso_type.dart';

abstract class TreeComponent {
  final String id;
  final String name;
  final ComponentType type;
  final SensorType? componentSensorType;
  final AssetStatus? componentStatus;

  TreeComponent({
    required this.id,
    required this.name,
    required this.type,
    String? sensorType,
    String? status,
  })  : componentSensorType = SensorType.fromString(sensorType),
        componentStatus = AssetStatus.fromString(status);
}
