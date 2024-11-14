import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';
import 'package:tractian/shared/assets/svgs/app_svgs.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/app_dimens.dart';
import 'package:tractian/shared/ui/app_gaps.dart';
import 'package:tractian/shared/ui/typography/typography.dart';

class CompanyCardWidget extends StatelessWidget {
  final CompanyEntity company;
  final VoidCallback onTapCompany;

  const CompanyCardWidget({super.key, required this.company, required this.onTapCompany});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCompany,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.xs),
        decoration: const BoxDecoration(
          color: AppColors.primaryCard,
          borderRadius: BorderRadius.all(Radius.circular(AppDimens.pico)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppSvgs.ic_company.path),
            AppGaps.xxxs,
            Text(company.name).bodyMediumMedium(),
          ],
        ),
      ),
    );
  }
}
