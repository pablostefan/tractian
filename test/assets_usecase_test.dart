import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase_imp.dart';

import 'assets_usecase_test.mocks.dart';
import 'test_data.dart';

@GenerateNiceMocks([MockSpec<AssetsRepository>()])
void main() {
  late MockAssetsRepository mockRepository;
  late AssetsUseCaseImp useCase;

  // Mock data for tests
  const companyId = 'company-id';

  setUpAll(() {
    // Registrar valores padrão para os tipos que o Mockito não consegue gerar automaticamente
    provideDummy<Either<BaseFailure, List<LocationEntity>>>(const Right([]));
    provideDummy<Either<BaseFailure, List<AssetEntity>>>(const Right([]));
  });

  setUp(() {
    mockRepository = MockAssetsRepository();
    useCase = AssetsUseCaseImp(mockRepository);
  });

  group('AssetsUseCase', () {
    test('should return a tree of assets when repository getAssets', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Right(TestData.mockLocationsEntity));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Right(TestData.mockAssetsEntity));

      // Act
      final result = await useCase.getAssets(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(TestData.mockTreeEntities), reason: 'Not match the expected structure');
      expect(result.right, equals(TestData.mockTreeByUtils), reason: 'Not match the expected structure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return a tree of assets when repository filterBySearch', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Right(TestData.mockLocationsEntity));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Right(TestData.mockAssetsEntity));

      // Act
      final result = await useCase.filterBySearch(companyId, TestData.search);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(TestData.searchResultEntities), reason: 'Not match the expected structure');
      expect(result.right, equals(TestData.searchResultByUtils), reason: 'Not match the expected structure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return a tree of assets when repository filterByEnergySensor', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Right(TestData.mockLocationsEntity));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Right(TestData.mockAssetsEntity));

      // Act
      final result = await useCase.filterByEnergySensor(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(TestData.energySensorResultEntities), reason: 'Not match the expected structure');
      expect(result.right, equals(TestData.energySensorResultByUtils), reason: 'Not match the expected structure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return a tree of assets when repository filterByCriticalStatus', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Right(TestData.mockLocationsEntity));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Right(TestData.mockAssetsEntity));

      // Act
      final result = await useCase.filterByCriticalStatus(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(TestData.criticalStatusResultEntities), reason: 'Not match the expected structure');
      expect(result.right, equals(TestData.criticalStatusResultByUtils), reason: 'Not match the expected structure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return BaseFailure when getLocations fails', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Left(UnknownFailure()));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Right(TestData.mockAssetsEntity));

      // Act
      final result = await useCase.getAssets(companyId);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verifyNever(mockRepository.getAssets(companyId));
    });

    test('should return BaseFailure when getAssets fails', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => const Right([]));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Left(UnknownFailure()));

      // Act
      final result = await useCase.getAssets(companyId);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return BaseFailure when filterBySearch fails', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => const Right([]));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Left(UnknownFailure()));

      // Act
      final result = await useCase.filterBySearch(companyId, TestData.search);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return BaseFailure when filterByCriticalStatus fails', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => const Right([]));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Left(UnknownFailure()));

      // Act
      final result = await useCase.filterByCriticalStatus(companyId);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return BaseFailure when filterByEnergySensor fails', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => const Right([]));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Left(UnknownFailure()));

      // Act
      final result = await useCase.filterByEnergySensor(companyId);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });
  });
}
