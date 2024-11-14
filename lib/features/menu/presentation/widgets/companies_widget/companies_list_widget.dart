import 'package:flutter/material.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';
import 'package:tractian/features/menu/presentation/widgets/companies_widget/company_card_widget.dart';
import 'package:tractian/shared/ui/app_dimens.dart';
import 'package:tractian/shared/ui/app_gaps.dart';

class CompaniesListWidget extends StatelessWidget {
  final List<CompanyEntity> companies;
  final ValueChanged<CompanyEntity> onTapCompany;

  const CompaniesListWidget({super.key, required this.companies, required this.onTapCompany});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.xxs, vertical: AppDimens.xs),
      itemCount: companies.length,
      separatorBuilder: (_, __) => AppGaps.sm,
      itemBuilder: (context, index) {
        final company = companies[index];
        return CompanyCardWidget(
          company: company,
          onTapCompany: () => onTapCompany(company),
        );
      },
    );
  }
}
