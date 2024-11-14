import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';
import 'package:tractian/features/menu/domain/usecases/companies_usecase.dart';
import 'package:tractian/shared/widgets/alert_widget.dart';

class AppMenuController extends ChangeNotifier {
  final CompaniesUseCase _companiesUseCase;

  AppMenuController(this._companiesUseCase) {
    _getCompanies();
  }

  final List<CompanyEntity> _companies = [];

  UnmodifiableListView<CompanyEntity> get companies => UnmodifiableListView(_companies);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  void _setLoading(bool value) => isLoading.value = value;

  void _getCompanies() async {
    _setLoading(true);
    final result = await _companiesUseCase.getCompanies();
    result.fold(_setError, _getCompaniesSuccess);
    _setLoading(false);
  }

  void _getCompaniesSuccess(List<CompanyEntity> response) {
    _companies.addAll(response);
    notifyListeners();
  }

  void _setError(BaseFailure failure) {
    _setLoading(false);
    showToastWidget(AlertWidget(message: failure.message));
  }
}
