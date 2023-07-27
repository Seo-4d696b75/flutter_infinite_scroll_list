import 'package:flutter/foundation.dart';
import 'package:flutter_infinite_scroll_list/data/api/github_repository_api.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.g.dart';

final debugSearchDelayMilliSecProvider = StateProvider((_) => 1000);

final debugSearchErrorFlagProvider = StateProvider((_) => false);

@riverpod
SearchRepository searchRepository(SearchRepositoryRef ref) {
  return SearchRepository(
    api: ref.watch(githubRepositoryApiProvider),
    debugDelayMilliSec: ref.watch(debugSearchDelayMilliSecProvider),
    debugErrorFlag: ref.watch(debugSearchErrorFlagProvider),
  );
}

class SearchRepository {
  const SearchRepository({
    required this.api,
    required this.debugDelayMilliSec,
    required this.debugErrorFlag,
  });

  final GithubRepositoryApi api;
  final int debugDelayMilliSec;
  final bool debugErrorFlag;

  static const pageSize = 10;

  Future<GithubRepositorySearchResult> search({
    required String query,
    required int page,
  }) async {
    if (!kReleaseMode && debugDelayMilliSec > 0) {
      await Future<void>.delayed(Duration(milliseconds: debugDelayMilliSec));
    }
    if (!kReleaseMode && debugErrorFlag) {
      throw Exception('(debug) error happened');
    }
    final res = await api.search(
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
