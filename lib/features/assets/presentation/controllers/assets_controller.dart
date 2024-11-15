import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/features/assets/domain/entities/tree_entity.dart';
import 'package:tractian/features/assets/domain/usecases/assets_usecase.dart';
import 'package:tractian/shared/widgets/alert_widget.dart';

class AssetsController extends ChangeNotifier {
  final AssetsUseCase _assetsUseCase;

  AssetsController(this._assetsUseCase);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  final List<TreeEntity> _assetsTree = [];

  UnmodifiableListView<TreeEntity> get assetsTree => UnmodifiableListView(_assetsTree);

  void _setLoading(bool value) => isLoading.value = value;

  void getAssets(String companyId) async {
    _setLoading(true);
    final result = await _assetsUseCase.getAssets(companyId);
    result.fold(_setError, _getAssetsSuccess);
    _setLoading(false);
  }

  void _getAssetsSuccess(List<TreeEntity> response) {
    _assetsTree.addAll(response);
    notifyListeners();
  }

  void _setError(BaseFailure failure) {
    _setLoading(false);
    showToastWidget(AlertWidget(message: failure.message));
  }
}
