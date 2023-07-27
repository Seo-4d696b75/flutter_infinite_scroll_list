import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_infinite_scroll_list/data/api/github_repository_api.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/search_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.g.dart';

@riverpod
SearchRepository searchRepository(SearchRepositoryRef ref) {
  return SearchRepository(
    ref.watch(githubRepositoryApiProvider),
  );
}

class SearchRepository {
  SearchRepository(this._api);

  final GithubRepositoryApi _api;

  final _random = Random();

  static const pageSize = 10;

  Future<GithubRepositorySearchResult> search({
    required String query,
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (_random.nextDouble() < 0.3) {
      throw Exception('random error happened');
    }
    final res = await _api.search(
      query: query,
      page: page,
      perPage: pageSize,
    );
    if (res.incompleteResults) {
      debugPrint('Warn: Github rest api time limits exceeded!');
    }
    return GithubRepositorySearchResult(
      nextPage: (page - 1) * pageSize + res.items.length < res.totalCount
          ? page + 1
          : null,
      repositories: res.items,
    );
  }
}
