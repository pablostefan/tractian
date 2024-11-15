enum AssetStatus {
  operating,
  alert;

  static AssetStatus? fromString(String? status) {
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
