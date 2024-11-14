import 'package:either_dart/either.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';

abstract class AssetsRepository {
  Future<Either<BaseFailure, List<AssetEntity>>> getAssets(String companyId);

  Future<Either<BaseFailure, List<LocationEntity>>> locations(String companyId);
}
