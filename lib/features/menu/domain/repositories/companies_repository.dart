import 'package:either_dart/either.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';

abstract class CompaniesRepository {
  Future<Either<BaseFailure, List<CompanyEntity>>> getCompanies();
}
