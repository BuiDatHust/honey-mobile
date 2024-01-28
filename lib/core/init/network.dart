import 'package:dio/dio.dart';

class DioSingleton {
  static final DioSingleton _instance = DioSingleton._internal();
  late Dio client;
  factory DioSingleton() => _instance;
  DioSingleton._internal() {
    client = Dio(BaseOptions(
      baseUrl: 'https://',
    ));
  }
}
