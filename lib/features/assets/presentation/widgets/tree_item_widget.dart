import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/typography/typography.dart';

class TreeItemWidget extends StatelessWidget {
  final TreeEntry<TreeEntity> entry;

  const TreeItemWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return TreeIndentation(
      entry: entry,
      child: Row(
        children: [

          Text(entry.node.value.name).bodySmallRegular().color(AppColors.secondaryText),
        ],
      ),
    );
  }
}
