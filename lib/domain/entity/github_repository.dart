import 'package:flutter_infinite_scroll_list/domain/entity/github_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repository.freezed.dart';

part 'github_repository.g.dart';

@freezed
class GithubRepository with _$GithubRepository {
  const factory GithubRepository({
    required int id,
    required String name,
    required String fullName,
    required String htmlUrl,
    required String? description,
    required int stargazersCount,
    required int watchersCount,
    required int forksCount,
    required int openIssuesCount,
    required String? language,
    required GithubUser owner,
  }) = _GithubRepository;

  factory GithubRepository.fromJson(Map<String, dynamic> json) =>
      _$GithubRepositoryFromJson(json);
}
