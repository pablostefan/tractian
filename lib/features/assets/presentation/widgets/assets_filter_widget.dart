import 'package:flutter/material.dart';
import 'package:tractian/features/assets/presentation/widgets/filter_button_widget.dart';
import 'package:tractian/features/assets/presentation/widgets/search_text_field_widget.dart';
import 'package:tractian/l10n/translate.dart';
import 'package:tractian/shared/assets/svgs/app_svgs.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/app_dimens.dart';
import 'package:tractian/shared/ui/app_gaps.dart';

class AssetsFilterWidget extends StatelessWidget {
  final TextEditingController controller;

  const AssetsFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.xxxs),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
      child: Column(children: [
        SearchTextFieldWidget(controller: controller),
        AppGaps.nano,
        Row(
          children: [
            FilterButtonWidget(
              icon: AppSvgs.ic_energy,
              label: Translate.strings.energySensor,
              onPressed: () {},
              isSelected: false,
            ),
            AppGaps.nano,
            FilterButtonWidget(
              icon: AppSvgs.ic_exclamation,
              label: Translate.strings.critical,
              onPressed: () {},
              isSelected: false,
            ),
          ],
        )
      ]),
    );
  }
}
