import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test_task/api/api_service.dart';

@module
abstract class RegisterModule {
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
          logPrint: (object) => log(object.toString()),
          maxWidth: 90,
        ),
      );
    }
    return dio;
  }

  ApiService get apiService => ApiService(dio);
}
