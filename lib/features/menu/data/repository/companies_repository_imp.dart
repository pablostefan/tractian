import 'package:either_dart/either.dart';
import 'package:tractian/core/base/base_repository.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/menu/data/datasources/companies_datasource.dart';
import 'package:tractian/features/menu/data/dtos/company_dto.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';
import 'package:tractian/features/menu/domain/repositories/companies_repository.dart';

class CompaniesRepositoryImp extends BaseRepository implements CompaniesRepository {
  final CompaniesDataSource _companiesDataSource;

  CompaniesRepositoryImp(this._companiesDataSource);

  @override
  Future<Either<BaseFailure, List<CompanyEntity>>> getCompanies() async {
    return tryExecute<List<CompanyEntity>>(() async {
      final response = await _companiesDataSource.getCompanies();
      return response.map((company) => CompanyDto.fromJson(company)).toList();
    });
  }
}
