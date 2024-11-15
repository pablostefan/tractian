import 'package:tractian/shared/assets/svgs/app_svgs.dart';

enum AssetStatus {
  operating,
  alert;

  AppSvgs? get icon {
    switch (this) {
      case AssetStatus.alert:
        return AppSvgs.ic_ellipse;

      default:
        return null;
    }
  }

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
