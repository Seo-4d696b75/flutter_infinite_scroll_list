import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_infinite_scroll_list/data/api/dio.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/github_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_repository_api.freezed.dart';

part 'github_repository_api.g.dart';

@riverpod
GithubRepositoryApi githubRepositoryApi(
  GithubRepositoryApiRef ref,
) {
  return GithubRepositoryApi(
    ref.watch(apiDioProvider),
  );
}

class GithubRepositoryApi {
  const GithubRepositoryApi(this._dio);

  final Dio _dio;

  Future<GithubRepositorySearchResponse> search({
    required String query,
    required int page,
    required int perPage,
  }) async {
    final q = Uri.encodeQueryComponent(query);
    final res = await _dio.get<String>(
      '/search/repositories?page=$page&per_page=$perPage&q=$q',
    );
    final body = res.data;
    if (body == null) {
      throw DioException(
        requestOptions: res.requestOptions,
        response: res,
        message: 'empty body',
      );
    }
    final json = jsonDecode(body) as Map<String, dynamic>;
    return GithubRepositorySearchResponse.fromJson(json);
  }
}

@freezed
class GithubRepositorySearchResponse with _$GithubRepositorySearchResponse {
  const factory GithubRepositorySearchResponse({
    required int totalCount,
    required bool incompleteResults,
    required List<GithubRepository> items,
  }) = _GithubRepositorySearchResponse;

  factory GithubRepositorySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$GithubRepositorySearchResponseFromJson(json);
}
