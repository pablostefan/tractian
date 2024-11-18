import 'package:flutter/cupertino.dart';
import 'package:tractian/features/assets/domain/entities/tree_component.dart';

class TreeEntity {
  final UniqueKey key = UniqueKey();
  final TreeComponent value;
  List<TreeEntity> children;

  TreeEntity({required this.value, List<TreeEntity>? children}) : children = children ?? [];

  @override
  bool operator ==(Object other) {
    return other is TreeEntity && other.key == key;
  }

  @override
  int get hashCode => value.id.hashCode;
}
