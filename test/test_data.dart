import 'package:tractian/features/assets/data/dtos/asset_dto.dart';
import 'package:tractian/features/assets/data/dtos/location_dto.dart';
import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/enums/assets_status.dart';
import 'package:tractian/features/assets/domain/entities/enums/senso_type.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/domain/utils/tree_utils.dart';
import 'package:tractian/features/menu/data/dtos/company_dto.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';

abstract class TestData {
  /// Mock data for search
  static String search = 'Asset 2';

  /// Mock data for companies json
  static List<Map<String, dynamic>> mockCompaniesJson = [
    {"id": "662fd0ee639069143a8fc387", "name": "Jaguar"},
    {"id": "662fd0fab3fd5656edb39af5", "name": "Tobias"},
    {"id": "662fd100f990557384756e58", "name": "Apex"}
  ];

  /// Mock data for locations json
  static List<Map<String, dynamic>> mockLocationsJson = [
    {"id": "1", "name": "Location 1", "parentId": null},
    {"id": "2", "name": "Location 2", "parentId": "1"}
  ];

  /// Mock data for assets json
  static List<Map<String, dynamic>> mockAssetsJson = [
    {"id": "3", "name": "Asset 1", "locationId": "2"},
    {"id": "4", "name": "Asset 2", "parentId": "3", "sensorType": "energy", "status": "alert"},
    {"id": "5", "name": "Asset 3", "status": "alert", "locationId": "1"},
    {"id": "6", "name": "Asset 4", "sensorType": "energy"}
  ];

  /// Mock data for companies
  static final mockCompaniesEntity = [
    CompanyEntity(id: "662fd0ee639069143a8fc387", name: "Jaguar"),
    CompanyEntity(id: "662fd0fab3fd5656edb39af5", name: "Tobias"),
    CompanyEntity(id: "662fd100f990557384756e58", name: "Apex")
  ];

  /// Mock data for locations
  static final mockLocationsEntity = [
    LocationEntity(id: '1', name: 'Location 1', parentId: null),
    LocationEntity(id: '2', name: 'Location 2', parentId: '1'),
  ];

  /// Mock data for assets
  static final mockAssetsEntity = [
    AssetEntity(id: '3', name: 'Asset 1', locationId: '2'),
    AssetEntity(id: '4', name: 'Asset 2', parentId: '3', sensorType: "energy", status: "alert"),
    AssetEntity(id: '5', name: 'Asset 3', status: "alert", locationId: '1'),
    AssetEntity(id: '6', name: 'Asset 4', sensorType: "energy"),
  ];

  /// Mock data for companies dto
  static List<CompanyEntity> get mockCompaniesDto {
    return mockCompaniesJson.map((json) => CompanyDto.fromJson(json)).toList();
  }

  /// Mock data for locations dto
  static List<LocationEntity> get mockLocationsDto {
    return mockLocationsJson.map((json) => LocationDto.fromJson(json)).toList();
  }

  /// Mock data for assets dto
  static List<AssetEntity> get mockAssetsDto {
    return mockAssetsJson.map((json) => AssetsDto.fromJson(json)).toList();
  }

  /// Mock data for tree
  static final mockTreeEntities = [
    TreeEntity(value: LocationEntity(id: '1', name: 'Location 1', parentId: null), children: [
      TreeEntity(value: LocationEntity(id: '2', name: 'Location 2', parentId: '1'), children: [
        TreeEntity(value: AssetEntity(id: '3', name: 'Asset 1', locationId: '2'), children: [
          TreeEntity(value: AssetEntity(id: '4', name: 'Asset 2', parentId: '3', sensorType: "energy", status: "alert"))
        ])
      ]),
      TreeEntity(value: AssetEntity(id: '5', name: 'Asset 3', status: "alert", locationId: '1')),
    ]),
    TreeEntity(value: AssetEntity(id: '6', name: 'Asset 4', sensorType: "energy")),
  ];

  /// Mock data for search result
  static final searchResultEntities = [
    TreeEntity(value: LocationEntity(id: '1', name: 'Location 1', parentId: null), children: [
      TreeEntity(value: LocationEntity(id: '2', name: 'Location 2', parentId: '1'), children: [
        TreeEntity(value: AssetEntity(id: '3', name: 'Asset 1', locationId: '2'), children: [
          TreeEntity(value: AssetEntity(id: '4', name: 'Asset 2', parentId: '3', sensorType: "energy", status: "alert"))
        ])
      ])
    ])
  ];

  /// Mock data for energy sensor result
  static final energySensorResultEntities = [
    TreeEntity(value: LocationEntity(id: '1', name: 'Location 1', parentId: null), children: [
      TreeEntity(value: LocationEntity(id: '2', name: 'Location 2', parentId: '1'), children: [
        TreeEntity(value: AssetEntity(id: '3', name: 'Asset 1', locationId: '2'), children: [
          TreeEntity(value: AssetEntity(id: '4', name: 'Asset 2', parentId: '3', sensorType: "energy", status: "alert"))
        ])
      ]),
    ]),
    TreeEntity(value: AssetEntity(id: '6', name: 'Asset 4', sensorType: "energy")),
  ];

  /// Mock data for critical status result
  static final criticalStatusResultEntities = [
    TreeEntity(value: LocationEntity(id: '1', name: 'Location 1', parentId: null), children: [
      TreeEntity(value: LocationEntity(id: '2', name: 'Location 2', parentId: '1'), children: [
        TreeEntity(value: AssetEntity(id: '3', name: 'Asset 1', locationId: '2'), children: [
          TreeEntity(value: AssetEntity(id: '4', name: 'Asset 2', parentId: '3', sensorType: "energy", status: "alert"))
        ])
      ]),
      TreeEntity(value: AssetEntity(id: '5', name: 'Asset 3', status: "alert", locationId: '1')),
    ]),
  ];

  /// Mock data for tree by utils
  static List<TreeEntity> get mockTreeByUtils => TreeUtils.build(mockLocationsEntity, mockAssetsEntity);

  /// Mock data for search result by utils
  static List<TreeEntity> get searchResultByUtils =>
      TreeUtils.searchHierarchy(mockTreeByUtils, (node) => node.value.name == search);

  /// Mock data for energy sensor result by utils
  static List<TreeEntity> get energySensorResultByUtils =>
      TreeUtils.searchHierarchy(mockTreeByUtils, (node) => node.value.componentSensorType == SensorType.energy);

  /// Mock data for critical status result by utils
  static List<TreeEntity> get criticalStatusResultByUtils =>
      TreeUtils.searchHierarchy(mockTreeByUtils, (node) => node.value.componentStatus == AssetStatus.alert);
}
