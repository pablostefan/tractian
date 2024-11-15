import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/presentation/widgets/tree_item_widget.dart';
import 'package:tractian/shared/ui/app_dimens.dart';

class TreeViewWidget extends StatefulWidget {
  final List<TreeEntity> tree;

  const TreeViewWidget({super.key, required this.tree});

  @override
  TreeViewWidgetState createState() => TreeViewWidgetState();
}

class TreeViewWidgetState extends State<TreeViewWidget> {
  late TreeController<TreeEntity> _treeController;

  void toggleExpansion(TreeEntity node) => _treeController.toggleExpansion(node);

  @override
  void initState() {
    super.initState();
    _treeController = TreeController<TreeEntity>(
      roots: widget.tree,
      parentProvider: (node) => node,
      childrenProvider: (node) => node.children,
    );
  }

  @override
  void didUpdateWidget(covariant TreeViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tree != widget.tree) {
      _treeController = TreeController<TreeEntity>(
        roots: widget.tree,
        parentProvider: (node) => node,
        childrenProvider: (node) => node.children,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedTreeView<TreeEntity>(
        treeController: _treeController,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.micro, vertical: AppDimens.xxs),
        nodeBuilder: (context, entry) {
          return InkWell(
            onTap: () => _treeController.toggleExpansion(entry.node),
            child: TreeItemWidget(entry: entry),
          );
        },
      ),
    );
  }
}
