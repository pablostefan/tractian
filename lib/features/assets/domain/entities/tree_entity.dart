import 'package:tractian/features/assets/domain/entities/tree_component.dart';

class TreeEntity {
  final TreeComponent value;
  List<TreeEntity> children;

  TreeEntity({required this.value}) : children = [];
}
