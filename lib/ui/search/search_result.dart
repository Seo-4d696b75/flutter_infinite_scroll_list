import 'package:flutter_infinite_scroll_list/data/repository/search_repository.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/github_repository.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_result.freezed.dart';

part 'search_result.g.dart';

final searchQueryProvider = StateProvider((_) => 'linux');

@freezed
class SearchResultState with _$SearchResultState {
  const factory SearchResultState({
    required String query,
    required int page,
    required int? nextPage,
    required List<GithubRepository> list,
  }) = _SearchResultState;
}

@riverpod
class SearchResult extends _$SearchResult {
  SearchRepository get _repository => ref.read(searchRepositoryProvider);

  @override
  Future<SearchResultState> build() async {
    final query = ref.watch(searchQueryProvider);
    try {
      final result = await _repository.search(query: query, page: 1);
      return SearchResultState(
        query: query,
        page: 1,
        nextPage: result.nextPage,
        list: result.repositories,
      );
    } on Exception catch (_) {
      if (state.isRefreshing || state.isReloading) {
        ref
            .read(searchErrorNotifierProvider.notifier)
            .onError(SearchErrorType.refreshOrReload);
      }
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
    state = const AsyncLoading<SearchResultState>().copyWithPrevious(previous);
    final next = await AsyncValue.guard(() async {
      final result = await _repository.search(
        query: value.query,
        page: page,
      );
      return value.copyWith(
        page: page,
        nextPage: result.nextPage,
        list: [
          ...value.list,
          ...result.repositories,
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
}
