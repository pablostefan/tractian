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

  /// Searches the tree structure for nodes that match a given condition.
  /// Returns the matching subtrees, preserving their structure.
  static List<TreeEntity> searchHierarchy(
    List<TreeEntity> forest,
    bool Function(TreeEntity) condition,
  ) {
    final results = <TreeEntity>[];

    for (final root in forest) {
      final queue = <TreeEntity>[]; // Queue for iterative processing.
      final matchingChildren = <TreeEntity>[]; // Collect matched children.

      // Add the root node to the queue for processing.
      queue.add(root);

      // Process the tree iteratively.
      while (queue.isNotEmpty) {
        final current = queue.removeAt(0);

        // Check if the current node matches the condition.
        if (condition(current)) {
          matchingChildren.add(current); // Add to matching children if it matches.
        } else {
          // If the current node doesn't match, process its children.
          queue.addAll(current.children);
        }
      }

      // If matching children were found, recreate the subtree with matched children.
      if (matchingChildren.isNotEmpty) {
        results.add(TreeEntity(value: root.value, children: matchingChildren));
      }
    }

    return results;
  }
}
