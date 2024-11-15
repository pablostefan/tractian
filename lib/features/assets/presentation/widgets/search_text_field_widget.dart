import 'package:flutter/material.dart';
import 'package:tractian/l10n/translate.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/app_dimens.dart';
import 'package:tractian/shared/ui/typography/typography_font_size.dart';
import 'package:tractian/shared/ui/typography/typography_font_weight.dart';
import 'package:tractian/shared/ui/typography/typography_line_height.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchTextFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.quaternaryIcon,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primaryTextField,
        hintText: Translate.strings.searchAssetLocation,
        hintStyle: const TextStyle(
          fontSize: TypographyFontSize.small,
          fontWeight: TypographyFontWeight.regular,
          height: TypographyLineHeight.body,
          color: AppColors.quaternaryIcon,
        ),

        prefixIcon: const Icon(Icons.search, color: AppColors.quaternaryIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.femto),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
