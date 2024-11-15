import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/presentation/widgets/tree_item_widget.dart';

class TreeViewWidget extends StatefulWidget {
  final List<TreeEntity> tree;

  const TreeViewWidget({super.key, required this.tree});

  @override
  State<TreeViewWidget> createState() => _TreeViewWidgetState();
}

class _TreeViewWidgetState extends State<TreeViewWidget> {
  late TreeController<TreeEntity> _treeController;

  @override
  void initState() {
    super.initState();
    _treeController = TreeController<TreeEntity>(roots: widget.tree, childrenProvider: (node) => node.children);
  }

  @override
  void didUpdateWidget(covariant TreeViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _treeController = TreeController<TreeEntity>(roots: widget.tree, childrenProvider: (node) => node.children);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTreeView<TreeEntity>(
      treeController: _treeController,
      nodeBuilder: (context, entry) {
        return InkWell(
          onTap: () => _treeController.toggleExpansion(entry.node),
          child: TreeItemWidget(entry: entry),
        );
      },
    );
  }
}
