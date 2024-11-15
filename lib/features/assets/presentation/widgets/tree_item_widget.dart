import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/features/assets/domain/entities/enums/assets_status.dart';
import 'package:tractian/features/assets/domain/entities/enums/senso_type.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/app_dimens.dart';
import 'package:tractian/shared/ui/app_gaps.dart';
import 'package:tractian/shared/ui/typography/typography.dart';

class TreeItemWidget extends StatelessWidget {
  final TreeEntry<TreeEntity> entry;

  const TreeItemWidget({super.key, required this.entry});

  double get _turns => entry.isExpanded ? 0 : -.25;

  @override
  Widget build(BuildContext context) {
    return TreeIndentation(
      entry: entry,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.pico),
        child: Row(
          children: [
            Visibility(
              visible: entry.node.children.isNotEmpty,
              child: AnimatedRotation(
                turns: _turns,
                duration: Durations.medium3,
                child: const Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
            Image.asset(entry.node.value.type.icon.path),
            AppGaps.pico,
            Expanded(child: Text(entry.node.value.name).bodySmallRegular().color(AppColors.secondaryText)),
            Visibility(
                visible: entry.node.value.componentSensorType == SensorType.energy,
                child: SvgPicture.asset(entry.node.value.componentSensorType?.icon?.path ?? "")),
            Visibility(
                visible: entry.node.value.componentStatus == AssetStatus.alert,
                child: SvgPicture.asset(entry.node.value.componentStatus?.icon?.path ?? "")),
          ],
        ),
      ),
    );
  }
}
