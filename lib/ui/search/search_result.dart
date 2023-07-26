import 'package:flutter_infinite_scroll_list/data/repository/search_repository.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/search_result.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_error.dart';
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
    try {
      return await _repository.search(query: query, page: 1);
    } on Exception catch (_) {
      ref
          .read(searchErrorNotifierProvider.notifier)
          .onError(SearchErrorType.first);
      rethrow;
    }
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
        .copyWithPrevious(previous);
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
    if (next.hasError) {
      ref
          .read(searchErrorNotifierProvider.notifier)
          .onError(SearchErrorType.loadMore);
    }
    state = next.copyWithPrevious(previous);
  }

  Future<void> refresh() async {
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
    if (next.hasError) {
      ref
          .read(searchErrorNotifierProvider.notifier)
          .onError(SearchErrorType.refresh);
    }
    state = next.copyWithPrevious(previous);
  }
}
