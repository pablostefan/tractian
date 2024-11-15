import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/enums/assets_status.dart';
import 'package:tractian/features/assets/domain/entities/enums/senso_type.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase.dart';
import 'package:tractian/features/assets/domain/utils/tree_utils.dart';
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

  // State management
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isCriticalSelectedNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isEnergySensorSelectedNotifier = ValueNotifier(false);

  // Asset tree data
  final List<TreeEntity> _allAssetsTree = [];
  List<TreeEntity> _visibleAssetsTree = [];

  // External access to the filtered tree
  UnmodifiableListView<TreeEntity> get visibleAssetsTree => UnmodifiableListView(_visibleAssetsTree);

  // Search controller
  final TextEditingController assetSearchController = TextEditingController();

  // Private method to set loading state
  void _setLoading(bool value) => isLoadingNotifier.value = value;

  // Add listener to search controller
  void _addSearchListener() {
    assetSearchController.addListener(_filterAssets);
  }

  // Fetch assets from use case
  Future<void> fetchAssets(String companyId) async {
    _setLoading(true);
    final result = await _assetsUseCase.getAssets(companyId);
    result.fold(_handleError, _handleAssetsFetched);
    _setLoading(false);
  }

  // Handle successful asset fetching
  void _handleAssetsFetched(List<TreeEntity> response) {
    _allAssetsTree.addAll(response);
    _visibleAssetsTree.addAll(response);
    notifyListeners();
  }

  // Handle error during fetching
  void _handleError(BaseFailure failure) {
    _setLoading(false);
    showToastWidget(AlertWidget(message: failure.message));
  }

  // Apply filter for energy sensor
  void filterByEnergySensor() {
    isEnergySensorSelectedNotifier.value = !isEnergySensorSelectedNotifier.value;
    _filterAssets();
  }

  // Apply filter for critical status
  void filterByCriticalStatus() {
    isCriticalSelectedNotifier.value = !isCriticalSelectedNotifier.value;
    _filterAssets();
  }

  // Filter assets based on search and filters
  void _filterAssets() {
    List<TreeEntity> assets = _allAssetsTree;

    if (isEnergySensorSelectedNotifier.value) {
      assets = TreeUtils.searchInForest(assets, (node) => node.value.componentSensorType == SensorType.energy);
    }
    if (isCriticalSelectedNotifier.value) {
      assets = TreeUtils.searchInForest(assets, (node) => node.value.componentStatus == AssetStatus.alert);
    }
    if (assetSearchController.text.isNotEmpty) {
      var text = assetSearchController.text.toLowerCase();
      assets = TreeUtils.searchInForest(assets, (node) => node.value.name.toLowerCase().contains(text));
    }

    _visibleAssetsTree = assets;
    notifyListeners();
  }
}
