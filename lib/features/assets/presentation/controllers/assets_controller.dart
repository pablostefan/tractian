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

  AssetsController(this._assetsUseCase);

  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> criticalSelected = ValueNotifier(false);
  ValueNotifier<bool> energySensorSelected = ValueNotifier(false);

  final List<TreeEntity> _defaultAssetsTree = [];

  List<TreeEntity> _filteredAssetsTree = [];

  UnmodifiableListView<TreeEntity> get assetsTree => UnmodifiableListView(_filteredAssetsTree);

  TextEditingController searchController = TextEditingController();

  void _setLoading(bool value) => isLoading.value = value;

  Future<void> getAssets(String companyId) async {
    _setLoading(true);
    final result = await _assetsUseCase.getAssets(companyId);
    result.fold(_setError, _getAssetsSuccess);
    _setLoading(false);
  }

  void _getAssetsSuccess(List<TreeEntity> response) {
    _defaultAssetsTree.addAll(response);
    _filteredAssetsTree.addAll(response);
    notifyListeners();
  }

  void _setError(BaseFailure failure) {
    _setLoading(false);
    showToastWidget(AlertWidget(message: failure.message));
  }

  void filterEnergySensor() {
    energySensorSelected.value = !energySensorSelected.value;
    if (energySensorSelected.value) {
      _filteredAssetsTree =
          TreeUtils.searchInForest(_defaultAssetsTree, (node) => node.value.componentSensorType == SensorType.energy);
    } else {
      _filteredAssetsTree = _defaultAssetsTree;
    }
    notifyListeners();
  }

  void filterCritical() {
    criticalSelected.value = !criticalSelected.value;

    if (criticalSelected.value) {
      _filteredAssetsTree =
          TreeUtils.searchInForest(_defaultAssetsTree, (node) => node.value.componentStatus == AssetStatus.alert);
    } else {
      _filteredAssetsTree = _defaultAssetsTree;
    }
    notifyListeners();
  }
}
