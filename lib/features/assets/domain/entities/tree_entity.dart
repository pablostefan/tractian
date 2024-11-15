import 'package:tractian/features/assets/domain/entities/base_entity.dart';

class TreeEntity {
  final BaseEntity value;
  List<TreeEntity> children;

  TreeEntity({required this.value}) : children = [];
}
