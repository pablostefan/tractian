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
  final VoidCallback filterEnergySensor;
  final VoidCallback filterCritical;
  final ValueNotifier<bool> energySensorSelected;
  final ValueNotifier<bool> criticalSelected;

  const AssetsFilterWidget({
    super.key,
    required this.controller,
    required this.filterEnergySensor,
    required this.filterCritical,
    required this.energySensorSelected,
    required this.criticalSelected,
  });

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
            ValueListenableBuilder(
                valueListenable: energySensorSelected,
                builder: (_, value, __) {
                  return FilterButtonWidget(
                    icon: AppSvgs.ic_energy,
                    label: Translate.strings.energySensor,
                    onPressed: filterEnergySensor,
                    isSelected: value,
                  );
                }),
            AppGaps.nano,
            ValueListenableBuilder(
                valueListenable: criticalSelected,
                builder: (_, value, __) {
                  return FilterButtonWidget(
                    icon: AppSvgs.ic_exclamation,
                    label: Translate.strings.critical,
                    onPressed: filterCritical,
                    isSelected: value,
                  );
                }),
          ],
        )
      ]),
    );
  }
}
