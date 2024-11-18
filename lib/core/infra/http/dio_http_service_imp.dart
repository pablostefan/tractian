import 'package:dio/dio.dart';
import 'package:tractian/core/error/base_failure.dart';
import 'package:tractian/core/infra/http/http_service.dart';

class DioHttpServiceImp implements HttpService {
  final Dio _dio;

  DioHttpServiceImp(this._dio);

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    try {
      return _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw NetworkFailure.fromDioException(e);
    } catch (e, s) {
      throw UnknownFailure(stackTrace: s);
    }
  }
}
