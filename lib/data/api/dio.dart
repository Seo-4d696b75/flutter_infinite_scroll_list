import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_infinite_scroll_list/data/api/access_token.dart';
import 'package:flutter_infinite_scroll_list/data/api/auth_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@riverpod
String apiDomain(ApiDomainRef ref) {
  return 'api.github.com';
}

@riverpod
Dio apiDio(ApiDioRef ref) {
  final domain = ref.watch(apiDomainProvider);
  final dio = Dio(
    BaseOptions(baseUrl: 'https://$domain'),
  );
  dio.interceptors.add(
    AuthorizationInterceptor(
      ref.watch(accessTokenProvider),
    ),
  );
  if (!kReleaseMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  return dio;
}
