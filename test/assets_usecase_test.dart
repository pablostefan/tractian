import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/domain/repositories/assets_repository.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase_imp.dart';
import 'package:tractian/features/assets/domain/utils/tree_utils.dart';

import 'assets_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AssetsRepository>()])
void main() {
  late MockAssetsRepository mockRepository;
  late AssetsUseCaseImp useCase;

  // Mock data for tests
  const companyId = 'company-id';

  final mockLocations = [
    LocationEntity(id: '1', name: 'Location 1', parentId: null),
    LocationEntity(id: '2', name: 'Location 2', parentId: '1'),
  ];

  final mockAssets = [
    AssetEntity(id: '3', name: 'Asset 1', locationId: '2'),
  ];

  final mockTree = [
    TreeEntity(value: LocationEntity(id: '1', name: 'Location 1', parentId: null), children: [
      TreeEntity(
          value: LocationEntity(id: '2', name: 'Location 2', parentId: '1'),
          children: [TreeEntity(value: AssetEntity(id: '3', name: 'Asset 1', locationId: '2'))])
    ])
  ];

  final mockTreeByUtils = TreeUtils.build(mockLocations, mockAssets);
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
    test('should return a tree of assets when repository succeeds', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Right(mockLocations));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Right(mockAssets));

      // Act
      final result = await useCase.getAssets(companyId);

      // Assert
      expect(result.isRight, true, reason: 'Expected Right but got Left');
      expect(result.right, equals(mockTree), reason: 'The returned tree does not match the expected structure');
      expect(result.right, equals(mockTreeByUtils), reason: 'The returned tree does not match the expected structure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });

    test('should return BaseFailure when getLocations fails', () async {
      // Arrange
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Left(UnknownFailure()));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Right(mockAssets));

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
      when(mockRepository.getLocations(companyId)).thenAnswer((_) async => Right(mockLocations));
      when(mockRepository.getAssets(companyId)).thenAnswer((_) async => Left(UnknownFailure()));

      // Act
      final result = await useCase.getAssets(companyId);

      // Assert
      expect(result.isLeft, true, reason: 'Expected Left but got Right');
      expect(result.left, isA<BaseFailure>(), reason: 'Expected a BaseFailure');
      verify(mockRepository.getLocations(companyId)).called(1);
      verify(mockRepository.getAssets(companyId)).called(1);
    });
  });
}
