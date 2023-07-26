import 'dart:io';

import 'package:dio/dio.dart';

class AuthorizationInterceptor extends Interceptor {
  const AuthorizationInterceptor(this._accessToken);

  final String _accessToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $_accessToken';
    handler.next(options);
  }
}
