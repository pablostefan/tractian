import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/enums/assets_status.dart';
import 'package:tractian/features/assets/domain/entities/enums/senso_type.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/domain/utils/tree_utils.dart';

abstract class TestData {
  /// Mock data for search
  static String search = 'Asset 2';

  /// Mock data for locations
  static final mockLocations = [
    LocationEntity(id: '1', name: 'Location 1', parentId: null),
    LocationEntity(id: '2', name: 'Location 2', parentId: '1'),
  ];

  /// Mock data for assets
  static final mockAssets = [
    AssetEntity(id: '3', name: 'Asset 1', locationId: '2'),
    AssetEntity(id: '4', name: 'Asset 2', parentId: '3', sensorType: "energy", status: "alert"),
    AssetEntity(id: '5', name: 'Asset 3', status: "alert", locationId: '1'),
    AssetEntity(id: '6', name: 'Asset 4', sensorType: "energy"),
  ];

  /// Mock data for tree
  static final mockTree = [
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
  static final searchResult = [
    TreeEntity(value: LocationEntity(id: '1', name: 'Location 1', parentId: null), children: [
      TreeEntity(value: LocationEntity(id: '2', name: 'Location 2', parentId: '1'), children: [
        TreeEntity(value: AssetEntity(id: '3', name: 'Asset 1', locationId: '2'), children: [
          TreeEntity(value: AssetEntity(id: '4', name: 'Asset 2', parentId: '3', sensorType: "energy", status: "alert"))
        ])
      ])
    ])
  ];

  /// Mock data for energy sensor result
  static final energySensorResult = [
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
  static final criticalStatusResult = [
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
  static List<TreeEntity> get mockTreeByUtils => TreeUtils.build(mockLocations, mockAssets);

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
