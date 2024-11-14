import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';

class MenuController extends ChangeNotifier {
  final List<CompanyEntity> _companies = [];

  UnmodifiableListView<CompanyEntity> get companies => UnmodifiableListView(_companies);
}
