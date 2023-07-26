import 'dart:convert';
import 'dart:io';

import 'package:flutter_infinite_scroll_list/data/api/github_repository_api.dart';
import 'package:flutter_infinite_scroll_list/gen/assets.gen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GithubRepositorySearchResponse', () {
    final path = Assets.test.json.githubRepositoryReponse;
    final str = File(path).readAsStringSync();
    final json = jsonDecode(str) as Map<String, dynamic>;
    final res = GithubRepositorySearchResponse.fromJson(json);

    expect(res.totalCount, 40);
    expect(res.incompleteResults, isFalse);
    expect(res.items.length, 1);

    final repo = res.items[0];
    expect(repo.name, 'Tetris');
    expect(repo.id, 3081286);

    final owner = repo.owner;
    expect(owner.login, 'dtrupenn');
    expect(owner.id, 872147);
  });
}
