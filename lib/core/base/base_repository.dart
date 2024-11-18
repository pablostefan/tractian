import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:tractian/core/error/base_failure.dart';

abstract class BaseRepository {
  Future<Either<BaseFailure, T>> executeSafely<T>(Future<T> Function() exec) async {
    try {
      T result = await exec();
      return Right(result);
    } on BaseFailure catch (e) {
      _logErrorResponse(e);
      return Left(e);
    } on Exception catch (e, s) {
      final exceptionFailure = ExceptionFailure.fromException(e, s);
      _logErrorResponse(exceptionFailure);
      return Left(exceptionFailure);
    } catch (e, s) {
      final unknownFailure = UnknownFailure(stackTrace: s);
      _logErrorResponse(unknownFailure);
      return Left(unknownFailure);
    }
  }

  void _logErrorResponse(BaseFailure failure) {
    debugPrint('[ERROR RESPONSE REPOSITORY]');
    debugPrint('Type: ${failure.runtimeType}');
    debugPrint('Details: ${failure.toString()}');
  }
}
