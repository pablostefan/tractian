import 'package:either_dart/either.dart';
import 'package:tractian/core/base/base_usecase.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/enums/assets_status.dart';
import 'package:tractian/features/assets/domain/entities/enums/senso_type.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase.dart';
import 'package:tractian/features/assets/domain/utils/tree_utils.dart';

class AssetsUseCaseImp extends BaseUseCase implements AssetsUseCase {
  final AssetsRepository _assetsRepository;

  AssetsUseCaseImp(this._assetsRepository);

  @override
  Future<Either<BaseFailure, List<TreeEntity>>> getAssets(String companyId) async {
    return executeSafely(() async {
      List<AssetEntity> assetsList = [];
      List<LocationEntity> locationsList = [];

      var locations = await _assetsRepository.getLocations(companyId);
      locations.fold((error) => throw error, (success) => locationsList = success);

      var assets = await _assetsRepository.getAssets(companyId);
      assets.fold((error) => throw error, (success) => assetsList = success);

      final tree = TreeUtils.build(locationsList, assetsList);

      return tree;
    });
  }

  @override
  Future<Either<BaseFailure, List<TreeEntity>>> filterAssets({
    required String companyId,
    String search = '',
    bool isCritical = false,
    bool isEnergySensor = false,
  }) async {
    return executeSafely(() async {
      List<AssetEntity> assetsList = [];
      List<LocationEntity> locationsList = [];

      var locations = await _assetsRepository.getLocations(companyId);
      locations.fold((error) => throw error, (success) => locationsList = success);

      var assets = await _assetsRepository.getAssets(companyId);
      assets.fold((error) => throw error, (success) => assetsList = success);

      final tree = TreeUtils.build(locationsList, assetsList);

      final lowerSearch = search.toLowerCase();

      return TreeUtils.searchHierarchy(tree, (node) {
        final isNameMatch = lowerSearch.isNotEmpty ? node.value.name.toLowerCase().contains(lowerSearch) : true;
        final isCriticalMatch = isCritical ? node.value.componentStatus == AssetStatus.alert : true;
        final isEnergySensorMatch = isEnergySensor ? node.value.componentSensorType == SensorType.energy : true;

        return isNameMatch && isCriticalMatch && isEnergySensorMatch;
      });
    });
  }
}
