import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:flutter_infinite_scroll_list/ui/search/section/repository_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchResultPage extends ConsumerWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchResultProvider);
    final value = state.requireValue;

    return RefreshIndicator(
      onRefresh: ref.read(searchResultProvider.notifier).reload,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, idx) {
                final repo = value.repositories[idx];
                return RepositoryItem(repo: repo);
              },
              childCount: value.repositories.length,
            ),
          ),
          if (state.isLoading && !state.isRefreshing)
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
