import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:trendy_movies/src/application/utils/environment_config.dart';

class CustomHttpClient {
  CustomHttpClient() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
    dio.options.queryParameters
        .putIfAbsent('api_key', () => EnvironmentConfig.theMovieDbApiKey);
    dio.options
      ..connectTimeout = _timeOut
      ..receiveTimeout = _timeOut
      ..connectTimeout = _timeOut
      ..sendTimeout = _timeOut;
  }
  final dio = Dio();
  //in seconds
  static const _timeOut = 40000;
}
