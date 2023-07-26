import 'package:flutter_infinite_scroll_list/data/repository/search_repository.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_result.g.dart';

final searchQueryProvider = StateProvider((_) => 'linux');

@riverpod
class SearchResult extends _$SearchResult {
  SearchRepository get _repository => ref.read(searchRepositoryProvider);

  @override
  Future<GithubRepositorySearchResult> build() async {
    final query = ref.watch(searchQueryProvider);
    return _repository.search(query: query, page: 1);
  }

  Future<void> loadMore() async {
    final previous = state;
    if (previous.isLoading || !previous.hasValue) {
      return;
    }
    final value = previous.requireValue;
    final page = value.nextPage;
    if (page == null) {
      return;
    }
    state = const AsyncLoading<GithubRepositorySearchResult>()
        .copyWithPrevious(previous, isRefresh: false);
    final next = await AsyncValue.guard(() async {
      final more = await _repository.search(
        query: value.query,
        page: page,
      );
      return more.copyWith(
        repositories: [
          ...value.repositories,
          ...more.repositories,
        ],
      );
    });
    state = next.copyWithPrevious(previous);
  }

  Future<void> reload() async {
    final previous = state;
    if (previous.isLoading) {
      return;
    }
    final query = ref.read(searchQueryProvider);
    state = const AsyncLoading<GithubRepositorySearchResult>()
        .copyWithPrevious(previous);
    final next = await AsyncValue.guard(
      () => _repository.search(
        query: query,
        page: 1,
      ),
    );
    state = next.copyWithPrevious(previous);
  }
}
