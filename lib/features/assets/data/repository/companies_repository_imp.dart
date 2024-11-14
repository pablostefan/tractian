import 'package:either_dart/either.dart';
import 'package:tractian/core/base/base_repository.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';
import 'package:tractian/features/assets/data/dtos/company_dto.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';

class AssetsRepositoryImp extends BaseRepository implements AssetsRepository {
  final AssetsDataSource _assetsDataSource;

  AssetsRepositoryImp(this._assetsDataSource);

  @override
  Future<Either<BaseFailure, List<AssetEntity>>> getAssets(String companyId) async {
    return tryExecute<List<AssetEntity>>(() async {
      final response = await _assetsDataSource.getAssets(companyId);
      return response.map((company) => AssetsDto.fromJson(company)).toList();
    });
  }
}
