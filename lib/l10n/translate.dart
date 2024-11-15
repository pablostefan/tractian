import 'strings/pt_br.dart';

abstract class Translate {
  static AppStrings strings = _getType();

  static T _getType<T extends AppStrings>() => AppPtBR() as T;
}

abstract class AppStrings {
  String get assets;
}
