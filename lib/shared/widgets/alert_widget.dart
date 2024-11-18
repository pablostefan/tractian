import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/app_dimens.dart';
import 'package:tractian/shared/ui/app_opacity.dart';
import 'package:tractian/shared/ui/typography/typography.dart';

enum AlertType {
  error._(AppColors.error, Icons.error),
  alert._(AppColors.alert, Icons.warning),
  success._(AppColors.success, Icons.check_circle);

  final Color color;
  final IconData icon;

  const AlertType._(this.color, this.icon);
}

class AlertWidget extends StatelessWidget {
  final String message;
  final AlertType type;

  const AlertWidget({super.key, required this.message, this.type = AlertType.error});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: const Offset(AppDimens.none, -AppDimens.micro),
        child: GestureDetector(
            onTap: () => dismissAllToast(showAnim: true),
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: AppDimens.xxxs),
                width: double.infinity,
                height: AppDimens.sm,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.xxxs),
                decoration:
                    BoxDecoration(color: type.color, borderRadius: BorderRadius.circular(AppDimens.nano), boxShadow: [
                  BoxShadow(
                      color: AppColors.monoBlack.withOpacity(AppOpacity.mediumLow),
                      offset: const Offset(AppDimens.atto, AppDimens.atto),
                      blurRadius: AppDimens.femto)
                ]),
                child: Row(children: [
                  Icon(type.icon, color: AppColors.monoWhite),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: AppDimens.nano),
                          child: Text(message).bodySmallMedium().color(AppColors.monoWhite)))
                ]))));
  }
}
