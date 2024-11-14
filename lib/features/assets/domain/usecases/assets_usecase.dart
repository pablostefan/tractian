import 'package:either_dart/either.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';

abstract class AssetsUseCase {
  Future<Either<BaseFailure, List<AssetEntity>>> getAssets(String companyId);
}
