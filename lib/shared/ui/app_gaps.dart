import 'package:gap/gap.dart';
import 'package:tractian/shared/ui/app_dimens.dart';

abstract class AppGaps {
  /// atto = 2 |
  static const Gap atto = Gap(AppDimens.atto);

  /// femto = 4 |
  static const Gap femto = Gap(AppDimens.femto);

  /// pico = 6 |
  static const Gap pico = Gap(AppDimens.pico);

  /// nano = 8 |
  static const Gap nano = Gap(AppDimens.nano);

  /// micro = 12 |
  static const Gap micro = Gap(AppDimens.micro);

  /// xxxs = 16 |
  static const Gap xxxs = Gap(AppDimens.xxxs);

  /// xxs = 24 |
  static const Gap xxs = Gap(AppDimens.xxs);

  /// xs = 32 |
  static const Gap xs = Gap(AppDimens.xs);

  /// sm = 40 |
  static const Gap sm = Gap(AppDimens.sm);

  /// md = 48 |
  static const Gap md = Gap(AppDimens.md);

  /// lg = 56 |
  static const Gap lg = Gap(AppDimens.lg);

  /// xl = 64 |
  static const Gap xl = Gap(AppDimens.xl);
}
