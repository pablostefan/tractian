import 'package:either_dart/either.dart';
import 'package:tractian/core/base/base_usecase.dart';
import 'package:tractian/core/error/base_failure.dart';
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
      var locations = await _assetsRepository.locations(companyId);
      var locationsList = locations.right;

      var assets = await _assetsRepository.getAssets(companyId);
      var assetsList = assets.right;

      final tree = TreeUtils.build(locationsList, assetsList);

      return tree;
    });
  }
}
