import 'package:either_dart/either.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase.dart';

class AssetsUseCaseImp implements AssetsUseCase {
  final AssetsRepository _assetsRepository;

  AssetsUseCaseImp(this._assetsRepository);

  @override
  Future<Either<BaseFailure, List<AssetEntity>>> getAssets(String companyId) async {
    return await _assetsRepository.getAssets(companyId);
  }
}
