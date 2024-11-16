import 'package:tractian/features/assets/domain/entities/asset_entity.dart';
import 'package:tractian/features/assets/domain/entities/location_entity.dart';
import 'package:tractian/features/assets/domain/entities/tree_component.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';

abstract class TreeUtils {
  /// Builds the tree structure from lists of [LocationEntity] and [AssetEntity].
  /// This method organizes the data hierarchically, linking locations and assets
  /// based on their parent or location IDs.
  static List<TreeEntity> build(List<LocationEntity> locations, List<AssetEntity> assets) {
    // Map to group children nodes by their parent ID.
    final Map<String, List<TreeComponent>> childrenByParentId = {};

    // Group locations by parent ID.
    for (var location in locations) {
      childrenByParentId.putIfAbsent(location.parentId ?? '', () => []).add(location);
    }

    // Group assets by parent ID or location ID.
    for (var asset in assets) {
      childrenByParentId.putIfAbsent(asset.parentId ?? '', () => []).add(asset);
      childrenByParentId.putIfAbsent(asset.locationId ?? '', () => []).add(asset);
    }

    // Identify root nodes (nodes with no parent).
    final List<TreeEntity> rootNodes = [];
    final queue = <TreeEntity>[];

    // Add root locations to the root list and processing queue.
    final rootLocations = locations.where((location) => location.unliked);
    for (var location in rootLocations) {
      final root = TreeEntity(value: location);
      rootNodes.add(root);
      queue.add(root);
    }

    // Add root assets to the root list and processing queue.
    final rootAssets = assets.where((asset) => asset.unliked);
    for (var asset in rootAssets) {
      final root = TreeEntity(value: asset);
      rootNodes.add(root);
      queue.add(root);
    }

    // Iteratively build the tree structure.
    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);

      // Retrieve the children of the current node.
      final children = childrenByParentId[current.value.id] ?? [];

      for (final child in children) {
        // Create a TreeEntity for each child and link it to the parent node.
        final childNode = TreeEntity(value: child);
        current.children.add(childNode);
        queue.add(childNode);
      }
    }

    return rootNodes;
  }

  static List<TreeEntity> searchHierarchy(List<TreeEntity> forest, bool Function(TreeEntity) condition) {
    final results = <TreeEntity>[];

    // Iterate through all root nodes in the forest
    for (final root in forest) {
      // Recreate the subtree with matching nodes using a helper function
      final matchingSubtree = _searchSubtree(root, condition);
      if (matchingSubtree != null) results.add(matchingSubtree);
    }

    return results;
  }

  /// Helper function to recursively search and rebuild the subtree
  /// containing only nodes that match the condition or have matching descendants.
  static TreeEntity? _searchSubtree(TreeEntity node, bool Function(TreeEntity) condition) {
    // Check if the current node matches the condition
    final matches = condition(node);

    // List to collect children that match the condition or have matching descendants
    final matchingChildren = <TreeEntity>[];

    // Process each child recursively
    for (final child in node.children) {
      final matchingChild = _searchSubtree(child, condition);
      if (matchingChild != null) matchingChildren.add(matchingChild); // Add matching child to the list
    }

    // If the current node matches or has matching children, rebuild the node
    if (matches || matchingChildren.isNotEmpty) return TreeEntity(value: node.value, children: matchingChildren);

    // If neither the node nor its children match, return null
    return null;
  }
}
