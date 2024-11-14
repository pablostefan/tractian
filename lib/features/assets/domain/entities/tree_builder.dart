import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_node.dart';

class TreeBuilder {
  /// Constrói a árvore a partir de listas de [LocationEntity] e [AssetEntity]
  static List<TreeNode> buildTree(
    List<LocationEntity> locations,
    List<AssetEntity> assets,
  ) {
    final locationMap = {for (var location in locations) location.id: TreeNode<LocationEntity>(value: location)};
    final assetMap = {for (var asset in assets) asset.id: TreeNode<AssetEntity>(value: asset)};

    List<TreeNode> rootNodes = [];

    // Organiza LocationEntitys
    for (var location in locations) {
      if (location.unliked) {
        rootNodes.add(locationMap[location.id]!);
      } else if (locationMap.containsKey(location.parentId)) {
        locationMap[location.parentId]!.children.add(locationMap[location.id]!);
      }
    }

    // Organiza AssetEntitys
    for (var asset in assets) {
      if (asset.unliked) {
        rootNodes.add(assetMap[asset.id]!);
      } else if (locationMap.containsKey(asset.parentId)) {
        locationMap[asset.parentId]!.children.add(assetMap[asset.id]!);
      } else if (assetMap.containsKey(asset.parentId)) {
        assetMap[asset.parentId]!.children.add(assetMap[asset.id]!);
      }
    }

    return rootNodes;
  }
}
