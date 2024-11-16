import 'package:either_dart/either.dart';
import 'package:tractian/core/base/base_repository.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';
import 'package:tractian/features/assets/data/dtos/asset_dto.dart';
import 'package:tractian/features/assets/data/dtos/location_dto.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';

class AssetsRepositoryImp extends BaseRepository implements AssetsRepository {
  final AssetsDataSource _assetsDataSource;

  AssetsRepositoryImp(this._assetsDataSource);

  @override
  Future<Either<BaseFailure, List<AssetEntity>>> getAssets(String companyId) async {
    return executeSafely<List<AssetEntity>>(() async {
      final response = await _assetsDataSource.getAssets(companyId);
      return response.map((company) => AssetsDto.fromJson(company)).toList();
    });
  }

  @override
  Future<Either<BaseFailure, List<LocationEntity>>> locations(String companyId) async {
    return executeSafely<List<LocationEntity>>(() async {
      final response = await _assetsDataSource.locations(companyId);
      return response.map((company) => LocationDto.fromJson(company)).toList();
    });
  }
}
