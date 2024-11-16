import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/menu/data/datasources/companies_datasource.dart';
import 'package:tractian/features/menu/data/dtos/company_dto.dart';
import 'package:tractian/features/menu/data/repositories/companies_repository_imp.dart';

import 'companies_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CompaniesDataSource>()])
void main() {
  late MockCompaniesDataSource mockDataSource;
  late CompaniesRepositoryImp repository;

  // Mock data for tests
  final mockCompaniesJson = [
    {"id": "662fd0ee639069143a8fc387", "name": "Jaguar"},
    {"id": "662fd0fab3fd5656edb39af5", "name": "Tobias"},
    {"id": "662fd100f990557384756e58", "name": "Apex"}
  ];

  final mockCompanies = mockCompaniesJson.map((json) => CompanyDto.fromJson(json)).toList();

  setUp(() {
    mockDataSource = MockCompaniesDataSource();
    repository = CompaniesRepositoryImp(mockDataSource);
  });

  group('CompaniesRepository', () {
    test('should return a list of CompanyEntity when data source succeeds', () async {
      // Arrange
      when(mockDataSource.getCompanies()).thenAnswer((_) async => mockCompaniesJson);

      // Act
      final result = await repository.getCompanies();

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(mockCompanies), reason: 'The returned companies do not match the mock data');
      verify(mockDataSource.getCompanies()).called(1);
    });

    test('should return BaseFailure when fetching companies fails', () async {
      // Arrange
      when(mockDataSource.getCompanies()).thenThrow(Exception('Data source error'));

      // Act
      final result = await repository.getCompanies();

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockDataSource.getCompanies()).called(1);
    });
  });
}
