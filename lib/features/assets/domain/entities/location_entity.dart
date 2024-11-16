import 'package:tractian/features/assets/domain/entities/enums/componente_type.dart';
import 'package:tractian/features/assets/domain/entities/tree_component.dart';

class LocationEntity extends TreeComponent {
  final String? parentId;

  LocationEntity({
    required super.id,
    required super.name,
    super.type = ComponentType.location,
    this.parentId,
  });

  bool get unliked => parentId == null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
