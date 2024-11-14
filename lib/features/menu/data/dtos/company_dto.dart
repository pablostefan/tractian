import 'package:tractian/features/menu/domain/entities/company_entity.dart';

extension CompanyDto on CompanyEntity {
  static CompanyEntity fromJson(Map<String, dynamic>? json) {
    return CompanyEntity(
      id: json?['id'] as String? ?? "",
      name: json?['name'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
