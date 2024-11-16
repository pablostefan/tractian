import 'package:either_dart/either.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';

abstract class AssetsUseCase {
  Future<Either<BaseFailure, List<TreeEntity>>> getAssets(String companyId);

  Future<Either<BaseFailure, List<TreeEntity>>> filterBySearch(String companyId, String query);

  Future<Either<BaseFailure, List<TreeEntity>>> filterByEnergySensor(String companyId);

  Future<Either<BaseFailure, List<TreeEntity>>> filterByCriticalStatus(String companyId);
}
