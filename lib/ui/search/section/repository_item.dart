import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/domain/entity/github_repository.dart';
import 'package:flutter_infinite_scroll_list/gen/assets.gen.dart';
import 'package:intl/intl.dart';

class RepositoryItem extends StatelessWidget {
  const RepositoryItem({super.key, required this.repo});

  final GithubRepository repo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            repo.owner.avatarUrl,
            width: 40,
            height: 40,
          ),
        ),
        title: Text(repo.fullName),
        subtitle: RepositoryDescription(repo: repo),
      ),
    );
  }
}

class RepositoryDescription extends StatelessWidget {
  const RepositoryDescription({super.key, required this.repo});

  final GithubRepository repo;

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.compact(locale: 'en_US');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          repo.description ?? repo.language ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Assets.icon.githubStar.svg(
              width: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(f.format(repo.stargazersCount)),
            const SizedBox(width: 8),
            Assets.icon.githubFork.svg(
              width: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(f.format(repo.forksCount)),
            const SizedBox(width: 8),
            Assets.icon.githubWatch.svg(
              width: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(f.format(repo.watchersCount)),
          ],
        )
      ],
    );
  }
}
