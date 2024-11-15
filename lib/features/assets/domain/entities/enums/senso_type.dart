import 'package:tractian/shared/assets/svgs/app_svgs.dart';

enum SensorType {
  vibration,
  energy;

  AppSvgs? get icon {
    switch (this) {
      case SensorType.energy:
        return AppSvgs.ic_bolt;

      default:
        return null;
    }
  }

  static SensorType? fromString(String? sensorType) {
    switch (sensorType) {
      case 'vibration':
        return SensorType.vibration;
      case 'energy':
        return SensorType.energy;
      default:
        return null;
    }
  }
}
