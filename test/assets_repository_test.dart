import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';
import 'package:tractian/features/assets/data/repositories/assets_repository_imp.dart';

import 'assets_repository_test.mocks.dart';
import 'test_data.dart';

@GenerateNiceMocks([MockSpec<AssetsDataSource>()])
void main() {
  late MockAssetsDataSource mockDataSource;
  late AssetsRepositoryImp repository;

  setUp(() {
    mockDataSource = MockAssetsDataSource();
    repository = AssetsRepositoryImp(mockDataSource);
  });

  group('AssetsRepository', () {
    const companyId = 'company-id';

    test('should return locations when data source succeeds', () async {
      // Arrange
      when(mockDataSource.getLocations(companyId)).thenAnswer((_) async => TestData.mockLocationsJson);

      // Act
      final result = await repository.getLocations(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(TestData.mockLocationsEntity), reason: 'The returned locations are incorrect');
      expect(result.right, equals(TestData.mockLocationsDto), reason: 'The returned locations are incorrect');
      verify(mockDataSource.getLocations(companyId)).called(1);
    });

    test('should return BaseFailure when fetching locations fails', () async {
      // Arrange
      when(mockDataSource.getLocations(companyId)).thenThrow(Exception('Data source error'));

      // Act
      final result = await repository.getLocations(companyId);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockDataSource.getLocations(companyId)).called(1);
    });

    test('should return assets when data source succeeds', () async {
      // Arrange
      when(mockDataSource.getAssets(companyId)).thenAnswer((_) async => TestData.mockAssetsJson);

      // Act
      final result = await repository.getAssets(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(TestData.mockAssetsEntity), reason: 'The returned assets are incorrect');
      expect(result.right, equals(TestData.mockAssetsDto), reason: 'The returned assets are incorrect');
      verify(mockDataSource.getAssets(companyId)).called(1);
    });

    test('should return BaseFailure when fetching assets fails', () async {
      // Arrange
      when(mockDataSource.getAssets(companyId)).thenThrow(Exception('Data source error'));

      // Act
      final result = await repository.getAssets(companyId);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockDataSource.getAssets(companyId)).called(1);
    });
  });
}
