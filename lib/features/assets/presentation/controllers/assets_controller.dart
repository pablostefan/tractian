import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/core/utils/debounce_utils.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase.dart';
import 'package:tractian/shared/widgets/alert_widget.dart';

class AssetsController extends ChangeNotifier {
  final AssetsUseCase _assetsUseCase;

  AssetsController(this._assetsUseCase) {
    _addSearchListener();
  }

  @override
  void dispose() {
    super.dispose();
    assetSearchController.dispose();
  }

  String _companyId = '';

  // Tree controller
  final TreeController<TreeEntity> treeController = TreeController<TreeEntity>(
    roots: [],
    childrenProvider: (node) => node.children,
  );

  // State management
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isCriticalSelectedNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isEnergySensorSelectedNotifier = ValueNotifier(false);

  // Asset tree data
  List<TreeEntity> _treeAssets = [];

  // External access to the filtered tree
  UnmodifiableListView<TreeEntity> get visibleAssets => UnmodifiableListView(_treeAssets);

  // Search controller
  final TextEditingController assetSearchController = TextEditingController();

  // Private method to set loading state
  void _setLoading(bool value) => isLoadingNotifier.value = value;

  // Add listener to search controller
  void _addSearchListener() => assetSearchController.addListener(_debounceSearch);

  // Fetch assets from use case
  void fetchAssets(String companyId) {
    _setCompanyId(companyId);
    _fetchAssets(companyId);
  }

  // Fetch assets from use case
  Future<void> _fetchAssets(String companyId) async {
    _setLoading(true);
    final result = await _assetsUseCase.getAssets(companyId);
    result.fold(_handleError, _handleAssetsFetched);
    _setLoading(false);
  }

  // Set company id
  void _setCompanyId(String companyId) => _companyId = companyId;

  // Handle successful asset fetching
  void _handleAssetsFetched(List<TreeEntity> response) {
    _treeAssets = List.from(response);
    treeController.roots = List.from(response);
    treeController.rebuild();
    notifyListeners();
  }

  // Debounce search filter
  void _debounceSearch() {
    if (assetSearchController.text.isNotEmpty) Debounce.call(_applyFilters);
  }

  // Handle error during fetching
  void _handleError(BaseFailure failure) {
    _setLoading(false);
    _showErrorToast(failure.message);
  }

  // Display error as toast
  void _showErrorToast(String message) {
    showToastWidget(AlertWidget(message: message));
  }

  // Toggle energy sensor filter
  void toggleEnergySensorFilter() {
    isEnergySensorSelectedNotifier.value = !isEnergySensorSelectedNotifier.value;
    _applyFilters();
  }

  // Toggle critical status filter
  void toggleCriticalStatusFilter() {
    isCriticalSelectedNotifier.value = !isCriticalSelectedNotifier.value;
    _applyFilters();
  }

  // Apply all active filters
  void _applyFilters() async {
    final result = await _assetsUseCase.filterAssets(
      companyId: _companyId,
      search: assetSearchController.text,
      isCritical: isCriticalSelectedNotifier.value,
      isEnergySensor: isEnergySensorSelectedNotifier.value,
    );
    result.fold(_handleError, _rebuildTree);
  }

  // Rebuild the tree with filtered assets
  void _rebuildTree(List<TreeEntity> assets) {
    if (assets != _treeAssets) {
      _treeAssets = assets;
      treeController.roots = _treeAssets;
      treeController.rebuild();

      // Expand nodes if filtered
      Future.delayed(Durations.short4, _toggleCascading);
    }
  }

  void _toggleCascading() {
    bool searchActive = assetSearchController.text.isNotEmpty;
    bool criticalActive = isCriticalSelectedNotifier.value;
    bool energyActive = isEnergySensorSelectedNotifier.value;

    if (searchActive || criticalActive || energyActive) {
      treeController.expandCascading(_treeAssets);
    } else {
      treeController.collapseCascading(_treeAssets);
    }
  }
}
