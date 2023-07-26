import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_user.freezed.dart';

part 'github_user.g.dart';

@freezed
class GithubUser with _$GithubUser {
  const factory GithubUser({
    required int id,
    required String login,
    required String avatarUrl,
    required String htmlUrl,
  }) = _GithubUser;

  factory GithubUser.fromJson(Map<String, dynamic> json) =>
      _$GithubUserFromJson(json);
}
