import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/shared/assets/svgs/app_svgs.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/app_dimens.dart';
import 'package:tractian/shared/ui/typography/typography.dart';

class FilterButtonWidget extends StatelessWidget {
  final AppSvgs icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  const FilterButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isSelected,
  });

  Color get _textColor => isSelected ? AppColors.primaryText : AppColors.tertiaryText;

  Color get _backgroundColor => isSelected ? AppColors.primaryButton : AppColors.secondaryButton;

  Color get _iconColor => isSelected ? AppColors.secondaryIcon : AppColors.tertiaryIcon;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: SvgPicture.asset(icon.path, colorFilter: ColorFilter.mode(_iconColor, BlendMode.srcIn)),
      style: FilledButton.styleFrom(
        backgroundColor: _backgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppDimens.femto),
        ),
      ),
      onPressed: onPressed,
      label: Text(label).bodySmallMedium().color(_textColor),
    );
  }
}
