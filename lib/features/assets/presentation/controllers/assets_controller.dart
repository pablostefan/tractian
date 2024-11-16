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
  final List<TreeEntity> _allAssets = [];
  List<TreeEntity> _filteredAssets = [];

  // External access to the filtered tree
  UnmodifiableListView<TreeEntity> get visibleAssets => UnmodifiableListView(_filteredAssets);

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
    _allAssets.addAll(response);
    _filteredAssets = List.from(response);
    treeController.roots = _allAssets;
    treeController.rebuild();
    notifyListeners();
  }

  // Debounce search filter
  void _debounceSearch() => Debounce.call(_applyFilters);

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
    var filteredAssets = List<TreeEntity>.from(_allAssets);

    if (assetSearchController.text.isNotEmpty) {
      filteredAssets = await _filterBySearch();
    }
    if (isEnergySensorSelectedNotifier.value) {
      filteredAssets = await _filterByEnergySensor();
    }
    if (isCriticalSelectedNotifier.value) {
      filteredAssets = await _filterByCriticalStatus();
    }

    if (filteredAssets != _filteredAssets) _rebuildTree(filteredAssets);
  }

  // Filter by search text
  Future<List<TreeEntity>> _filterBySearch() async {
    _setLoading(true);
    List<TreeEntity> tree = [];
    final query = assetSearchController.text;
    final result = await _assetsUseCase.filterBySearch(_companyId, query);
    result.fold(_handleError, (response) => tree = response);
    _setLoading(false);
    return tree;
  }

  // Filter by energy sensor
  Future<List<TreeEntity>> _filterByEnergySensor() async {
    _setLoading(true);
    List<TreeEntity> tree = [];
    final result = await _assetsUseCase.filterByEnergySensor(_companyId);
    result.fold(_handleError, (response) => tree = response);
    _setLoading(false);
    return tree;
  }

  // Filter by critical status
  Future<List<TreeEntity>> _filterByCriticalStatus() async {
    _setLoading(true);
    List<TreeEntity> tree = [];
    final result = await _assetsUseCase.filterByCriticalStatus(_companyId);
    result.fold(_handleError, (response) => tree = response);
    _setLoading(false);
    return tree;
  }

  // Rebuild the tree with filtered assets
  void _rebuildTree(List<TreeEntity> assets) {
    _filteredAssets = assets;
    treeController.roots = _filteredAssets;
    treeController.rebuild();

    // Expand nodes if filtered
    Future.delayed(Durations.short4, () {
      if (_filteredAssets.length < _allAssets.length) {
        treeController.expandCascading(_filteredAssets);
      } else {
        treeController.collapseCascading(_filteredAssets);
      }
    });
  }
}
