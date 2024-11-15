enum SensorType {
  vibration,
  energy;

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
