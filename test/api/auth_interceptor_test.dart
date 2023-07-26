import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_infinite_scroll_list/data/api/auth_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  const token = 'access_token';
  const interceptor = AuthorizationInterceptor(token);
  final dio = Dio()..interceptors.add(interceptor);
  final adapter = DioAdapter(dio: dio);

  const path = 'https://example.com/api';

  test('Auth interceptor', () async {
    adapter.onGet(
      path,
      (server) => server.reply(200, ''),
    );

    final res = await dio.get<String>(path);

    expect(
      res.requestOptions.headers[HttpHeaders.authorizationHeader],
      'Bearer $token',
    );
  });
}
