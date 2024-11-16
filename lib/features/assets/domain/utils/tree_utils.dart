import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_component.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';

abstract class TreeUtils {
  /// Builds the tree from lists of [LocationEntity] and [AssetEntity]
  static List<TreeEntity> build(List<LocationEntity> locations, List<AssetEntity> assets) {
    // Index assets and locations by parentId and locationId
    final Map<String, List<TreeComponent>> childrenByParentId = {};

    for (var location in locations) {
      childrenByParentId.putIfAbsent(location.parentId ?? '', () => []).add(location);
    }

    for (var asset in assets) {
      // Assets can be children of a parent or associated with a location
      childrenByParentId.putIfAbsent(asset.parentId ?? '', () => []).add(asset);
      childrenByParentId.putIfAbsent(asset.locationId ?? '', () => []).add(asset);
    }

    // Filter root nodes (entities with no parent)
    final rootEntities = <TreeEntity>[];
    final rootLocations = locations.where((location) => location.unliked);
    final rootAssets = assets.where((asset) => asset.unliked);

    rootEntities.addAll(rootLocations.map((location) => _buildTree(location, childrenByParentId)));
    rootEntities.addAll(rootAssets.map((asset) => _buildTree(asset, childrenByParentId)));

    return rootEntities;
  }

  /// Builds a tree node recursively
  static TreeEntity _buildTree(TreeComponent entity, Map<String, List<TreeComponent>> childrenByParentId) {
    final currentTreeNode = TreeEntity(value: entity);
    final childEntities = childrenByParentId[entity.id] ?? [];
    currentTreeNode.children.addAll(childEntities.map((child) => _buildTree(child, childrenByParentId)));

    return currentTreeNode;
  }

  /// Optimized search method to find all matching subtrees
  static List<TreeEntity> searchHierarchy(List<TreeEntity> forest, bool Function(TreeEntity) condition) {
    final results = <TreeEntity>[];

    for (final tree in forest) {
      final match = _optimizedSearchSubtree(tree, condition);
      if (match != null) results.add(match);
    }

    return results;
  }

  static TreeEntity? _optimizedSearchSubtree(TreeEntity node, bool Function(TreeEntity) condition) {
    // If the current node matches, return the entire subtree
    if (condition(node)) {
      return node;
    }

    // Search in children, keeping only matched subtrees
    final matchingChildren = <TreeEntity>[];
    for (final child in node.children) {
      final match = _optimizedSearchSubtree(child, condition);
      if (match != null) matchingChildren.add(match);

    }

    // If any children matched, create a new node with the matched children
    if (matchingChildren.isNotEmpty) {
      return TreeEntity(value: node.value, children: matchingChildren);
    }

    // No match in the node or its subtree
    return null;
  }
}
