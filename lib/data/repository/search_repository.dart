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
  const SearchRepository(this._api);

  final GithubRepositoryApi _api;

  Future<GithubRepositorySearchResult> search({
    required String query,
    required int page,
  }) async {
    final res = await _api.search(
      query: query,
      page: page,
      perPage: 20,
    );
    if (res.incompleteResults) {
      debugPrint('Warn: Github rest api time limits exceeded!');
    }
    return GithubRepositorySearchResult(
      query: query,
      nextPage:
          (page - 1) * 20 + res.items.length < res.totalCount ? page + 1 : null,
      repositories: res.items,
    );
  }
}
