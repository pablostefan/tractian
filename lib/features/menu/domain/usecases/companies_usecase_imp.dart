import 'package:either_dart/either.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';
import 'package:tractian/features/menu/domain/repositories/companies_repository.dart';
import 'package:tractian/features/menu/domain/usecases/companies_usecase.dart';

class CompaniesUseCaseImp implements CompaniesUseCase {
  final CompaniesRepository _companiesRepository;

  CompaniesUseCaseImp(this._companiesRepository);

  @override
  Future<Either<BaseFailure, List<CompanyEntity>>> getCompanies() async {
    return await _companiesRepository.getCompanies();
  }
}
