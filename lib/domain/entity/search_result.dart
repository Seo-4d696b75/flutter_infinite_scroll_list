import 'package:flutter_infinite_scroll_list/domain/entity/github_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result.freezed.dart';

@freezed
class GithubRepositorySearchResult with _$GithubRepositorySearchResult {
  const factory GithubRepositorySearchResult({
    required String query,
    required int? nextPage,
    required List<GithubRepository> repositories,
  }) = _GithubRepositorySearchResult;
}
