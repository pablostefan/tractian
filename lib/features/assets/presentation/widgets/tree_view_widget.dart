import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/presentation/widgets/tree_item_widget.dart';
import 'package:tractian/shared/ui/app_dimens.dart';

class TreeViewWidget extends StatefulWidget {
  final TreeController<TreeEntity> treeController;

  const TreeViewWidget({super.key, required this.treeController});

  @override
  TreeViewWidgetState createState() => TreeViewWidgetState();
}

class TreeViewWidgetState extends State<TreeViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedTreeView<TreeEntity>(
        treeController: widget.treeController,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.micro, vertical: AppDimens.xxs),
        nodeBuilder: (context, entry) {
          return InkWell(
            onTap: () => widget.treeController.toggleExpansion(entry.node),
            child: TreeItemWidget(entry: entry),
          );
        },
      ),
    );
  }
}
