import 'package:tractian/shared/assets/images/app_images.dart';

enum ComponentType {
  location._(AppImages.location),
  asset._(AppImages.codepen),
  component._(AppImages.cube);

  final AppImages icon;

  const ComponentType._(this.icon);

  static ComponentType fromSensorType(String? sensorType) {
    return (sensorType?.isEmpty ?? true) ? ComponentType.asset : ComponentType.component;
  }
}
