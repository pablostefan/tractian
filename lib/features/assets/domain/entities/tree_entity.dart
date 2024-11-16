import 'package:tractian/features/assets/domain/entities/tree_component.dart';

class TreeEntity {
  final TreeComponent value;
  List<TreeEntity> children;

  TreeEntity({required this.value, List<TreeEntity>? children}) : children = children ?? [];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TreeEntity && other.value.id == value.id;
  }

  @override
  int get hashCode => value.id.hashCode;
}
