import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/menu/domain/entities/company_entity.dart';
import 'package:tractian/features/menu/domain/usecases/companies_usecase.dart';
import 'package:tractian/shared/widgets/alert_widget.dart';

class AppMenuController extends ChangeNotifier {
  final CompaniesUseCase _companiesUseCase;

  AppMenuController(this._companiesUseCase) {
    _fetchCompanies();
  }

  // State management
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  // Companies data
  final List<CompanyEntity> _companies = [];

  UnmodifiableListView<CompanyEntity> get companies => UnmodifiableListView(_companies);

  // Private method to set loading state
  void _setLoading(bool value) => isLoadingNotifier.value = value;

  // Fetch companies from use case
  Future<void> _fetchCompanies() async {
    _setLoading(true);
    final result = await _companiesUseCase.getCompanies();
    result.fold(_handleError, _handleCompaniesFetched);
    _setLoading(false);
  }

  // Handle successful fetch
  void _handleCompaniesFetched(List<CompanyEntity> response) {
    _companies.clear(); // Clear existing data to avoid duplicates
    _companies.addAll(response);
    notifyListeners();
  }

  // Handle error during fetch
  void _handleError(BaseFailure failure) {
    _setLoading(false);
    _showErrorToast(failure.message);
  }

  // Display error as toast
  void _showErrorToast(String message) {
    showToastWidget(AlertWidget(message: message));
  }
}
