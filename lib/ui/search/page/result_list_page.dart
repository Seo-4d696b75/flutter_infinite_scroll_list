import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_error.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:flutter_infinite_scroll_list/ui/search/section/error_snackbar.dart';
import 'package:flutter_infinite_scroll_list/ui/search/section/repository_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResultListPage extends HookConsumerWidget {
  const ResultListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchResultProvider);
    final value = state.requireValue;

    final controller = useScrollController();

    useEffect(
      () {
        if (controller.hasClients) {
          controller.jumpTo(0);
        }
        return null;
      },
      [value.query],
    );

    ref.listen(searchErrorNotifierProvider, (_, notifier) {
      showErrorShackBar(
        context: context,
        ref: ref,
        type: notifier.type,
      );
    });

    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n.metrics.pixels == n.metrics.maxScrollExtent) {
          ref.read(searchResultProvider.notifier).loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () => ref.refresh(searchResultProvider.future),
        child: Stack(
          children: [
            CustomScrollView(
              controller: controller,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, idx) {
                      final repo = value.list[idx];
                      return RepositoryItem(repo: repo);
                    },
                    childCount: value.list.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                    child: Visibility(
                      // 追加読み込み中
                      // Note pull-to-refreshでも表示されるが大きな問題にはならない
                      visible: value.nextPage != null && state.isRefreshing,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (state.isReloading)
              // クエリ変更による検索中
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
