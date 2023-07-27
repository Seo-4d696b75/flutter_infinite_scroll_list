import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_error.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showErrorShackBar({
  required BuildContext context,
  required WidgetRef ref,
  required SearchErrorType type,
}) {
  final manager = ScaffoldMessenger.of(context);
  final snackBar = SnackBar(
    content: const Text('Search failed'),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Retry',
      onPressed: () {
        if (type == SearchErrorType.refreshOrReload) {
          ref.invalidate(searchResultProvider);
        } else if (type == SearchErrorType.loadMore) {
          ref.read(searchResultProvider.notifier).loadMore();
        }
      },
    ),
  );
  manager.showSnackBar(snackBar);
}
