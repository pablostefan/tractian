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

  static List<TreeEntity> searchInForest(List<TreeEntity> forest, bool Function(TreeEntity) condition) {
    final results = <TreeEntity>[];

    for (final tree in forest) {
      final match = _searchSubtree(tree, condition);
      if (match != null) results.add(match);
    }

    return results;
  }

  static TreeEntity? _searchSubtree(
    TreeEntity node,
    bool Function(TreeEntity) condition,
  ) {
    // Check if the current node matches the condition
    if (condition(node)) {
      // If it matches, we include the entire subtree
      return _cloneWithMatchedChildren(node, condition);
    }

    // If the node itself doesn't match, continue searching in its children
    final matchingChildren = <TreeEntity>[];

    for (final child in node.children) {
      final match = _searchSubtree(child, condition);
      if (match != null) matchingChildren.add(match);
    }

    // If any children match, create a new node preserving only the matching children
    if (matchingChildren.isNotEmpty) {
      return TreeEntity(value: node.value, children: matchingChildren);
    }

    // No match in the node or its subtree
    return null;
  }

  static TreeEntity _cloneWithMatchedChildren(
    TreeEntity node,
    bool Function(TreeEntity) condition,
  ) {
    // Recursively clone the node, keeping its entire structure
    return TreeEntity(
      value: node.value,
      children: node.children.map((child) => _cloneWithMatchedChildren(child, condition)).toList(),
    );
  }
}
