import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/base_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';

class TreeUtils {
  /// Builds the tree from lists of [LocationEntity] and [AssetEntity]
  static List<TreeEntity> build(List<LocationEntity> locations, List<AssetEntity> assets) {
    // Index assets and locations by parentId and locationId
    final Map<String, List<BaseEntity>> childrenByParentId = {};

    for (var location in locations) {
      childrenByParentId.putIfAbsent(location.parentId ?? '', () => []).add(location);
    }

    for (var asset in assets) {
      // Assets can be children of a parent or associated with a location
      childrenByParentId.putIfAbsent(asset.parentId ?? '', () => []).add(asset);
      childrenByParentId.putIfAbsent(asset.locationId ?? '', () => []).add(asset);
    }

    // Filter root nodes (entities with no parent)
    final rootNodes = <TreeEntity>[];
    final rootLocations = locations.where((location) => location.unliked);
    final rootAssets = assets.where((asset) => asset.unliked );

    rootNodes.addAll(rootLocations.map((location) => _buildTree(location, childrenByParentId)));
    rootNodes.addAll(rootAssets.map((asset) => _buildTree(asset, childrenByParentId)));

    return rootNodes;
  }

  /// Builds a tree node recursively
  static TreeEntity _buildTree(BaseEntity entity, Map<String, List<BaseEntity>> childrenByParentId) {
    final treeNode = TreeEntity(value: entity);

    final children = childrenByParentId[entity.id] ?? [];
    treeNode.children.addAll(children.map((child) => _buildTree(child, childrenByParentId)));

    return treeNode;
  }

  /// Performs a search in the tree based on a predicate
  static TreeEntity? searchTreeNode(List<TreeEntity> nodes, bool Function(TreeEntity) predicate) {
    for (var node in nodes) {
      if (predicate(node)) return node;

      var result = searchTreeNode(node.children, predicate);
      if (result != null) return result;
    }
    return null;
  }
}
