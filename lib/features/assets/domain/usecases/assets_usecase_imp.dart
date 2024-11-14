import 'package:either_dart/either.dart';
import 'package:tractian/core/base/base_repository.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_builder.dart';
import 'package:tractian/features/assets/domain/entities/tree_node.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase.dart';

class AssetsUseCaseImp extends BaseRepository implements AssetsUseCase {
  final AssetsRepository _assetsRepository;

  AssetsUseCaseImp(this._assetsRepository);

  @override
  Future<Either<BaseFailure, List<TreeNode>>> getAssets(String companyId) async {
    return tryExecute(() async {
      List<TreeNode> response = [];

      List<LocationEntity> locationsList = [];
      var locations = await _assetsRepository.locations(companyId);
      locations.fold((error) => throw error, (r) => locationsList = r);

      List<AssetEntity> assetsList = [];
      var assets = await _assetsRepository.getAssets(companyId);
      assets.fold((error) => throw error, (r) => assetsList = r);

      response = TreeBuilder.build(locationsList, assetsList);

      return response;
    });
  }
}
