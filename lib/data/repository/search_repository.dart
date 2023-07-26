import 'package:flutter/cupertino.dart';
import 'package:flutter_infinite_scroll_list/data/api/github_repository_api.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/github_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.freezed.dart';

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
      page: page,
      pageSize: 20,
      nextPage:
          (page - 1) * 20 + res.items.length < res.totalCount ? page + 1 : null,
      repositories: res.items,
    );
  }
}

@freezed
class GithubRepositorySearchResult with _$GithubRepositorySearchResult {
  const factory GithubRepositorySearchResult({
    required String query,
    required int page,
    required int pageSize,
    required int? nextPage,
    required List<GithubRepository> repositories,
  }) = _GithubRepositorySearchResult;
}
