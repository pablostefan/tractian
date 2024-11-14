import 'package:either_dart/either.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/tree_node.dart';

abstract class AssetsUseCase {
  Future<Either<BaseFailure, List<TreeNode>>> getAssets(String companyId);
}
