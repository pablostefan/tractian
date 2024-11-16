import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/data/datasources/assets_datasource.dart';
import 'package:tractian/features/assets/data/dtos/asset_dto.dart';
import 'package:tractian/features/assets/data/dtos/location_dto.dart';
import 'package:tractian/features/assets/data/repositories/assets_repository_imp.dart';

import 'assets_repository_test.mocks.dart';

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
      final mockLocationsJson = [
        {"id": "656a07b3f2d4a1001e2144bf", "name": "CHARCOAL STORAGE SECTOR", "parentId": "65674204664c41001e91ecb4"},
        {"id": "656733611f4664001f295dd0", "name": "Empty Machine house", "parentId": null}
      ];

      final mockLocations = mockLocationsJson.map((json) => LocationDto.fromJson(json)).toList();

      when(mockDataSource.getLocations(companyId)).thenAnswer((_) async => mockLocationsJson);

      // Act
      final result = await repository.getLocations(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(mockLocations), reason: 'The returned locations are incorrect');
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
      final mockAssetsJson = [
        {
          "gatewayId": "HND116",
          "id": "6092c987507faf0064b0a7bb",
          "locationId": "6092c8f567679000665ed5d2",
          "name": "Sensor 1 - energy",
          "parentId": null,
          "sensorId": "OOJ718",
          "sensorType": "energy",
          "status": "operating"
        },
        {
          "gatewayId": "ROL916",
          "id": "6080f10e98ac51001e7d77eb",
          "locationId": "607a11a07a51520020945cd6",
          "name": "Sensor 2 - energy",
          "parentId": null,
          "sensorId": "OYL361",
          "sensorType": "energy",
          "status": "operating"
        }
      ];

      final mockAssets = mockAssetsJson.map((json) => AssetsDto.fromJson(json)).toList();

      when(mockDataSource.getAssets(companyId)).thenAnswer((_) async => mockAssetsJson);

      // Act
      final result = await repository.getAssets(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(mockAssets), reason: 'The returned assets are incorrect');
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
